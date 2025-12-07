package controller

import (
	"database/sql"
	"net/http"
	"os"
	"time"

	"lms-apps/backend/internal/helpers/mailers"
	"lms-apps/backend/internal/helpers/password"
	"lms-apps/backend/package/config"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type ForgotPasswordRequest struct {
	Email string `json:"email" binding:"required,email"`
}

type ResetPasswordRequest struct {
	Token       string `json:"token" binding:"required"`
	NewPassword string `json:"new_password" binding:"required,min=6"`
}

// Forgot Password
func ForgotPasswordHandler(c *gin.Context) {
	var req ForgotPasswordRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Find the user by email.
	var userID string
	err := config.DB.QueryRow("SELECT id FROM users WHERE email=$1", req.Email).Scan(&userID)
	if err == sql.ErrNoRows {
		c.JSON(http.StatusOK, gin.H{"message": "If this email exists, reset link has been sent"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error"})
		return
	}

	// Remove any previous tokens for this user
	_, _ = config.DB.Exec("DELETE FROM tb_password_resets WHERE user_id=$1", userID)

	// create a new reset token record
	token := uuid.New().String()
	expiredAt := time.Now().Add(15 * time.Minute)
	resetID := uuid.New().String()

	_, err = config.DB.Exec(
		"INSERT INTO tb_password_resets (id, user_id, email, token, expired_at) VALUES ($1,$2,$3,$4,$5)",
		resetID, userID, req.Email, token, expiredAt,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create reset token"})
		return
	}

	frontend := os.Getenv("FRONTEND_URL")
	if frontend == "" {
		frontend = "http://localhost:3000"
	}
	resetURL := frontend + "/reset-password?token=" + token
	body := "<p>Click link below to reset your password:</p><p><a href='" + resetURL + "'>Reset Password</a></p>"

	if err := mailers.SendEmail(req.Email, "Password Reset", body); err != nil {
		// mailer logs error internally; do not leak details to client
		c.JSON(http.StatusOK, gin.H{"message": "If this email exists, reset link has been sent"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "If this email exists, reset link has been sent"})
}

// Reset Password
func ResetPasswordHandler(c *gin.Context) {
	var req ResetPasswordRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var userID string
	var expiredAt time.Time
	err := config.DB.QueryRow("SELECT user_id, expired_at FROM tb_password_resets WHERE token=$1", req.Token).
		Scan(&userID, &expiredAt)
	if err == sql.ErrNoRows {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid or expired token"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error"})
		return
	}

	if time.Now().After(expiredAt) {
		// delete expired token
		_, _ = config.DB.Exec("DELETE FROM tb_password_resets WHERE token=$1", req.Token)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Token expired"})
		return
	}

	hashedPassword, err := password.HashPassword(req.NewPassword)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to hash password"})
		return
	}

	_, err = config.DB.Exec("UPDATE users SET password=$1 WHERE id=$2", hashedPassword, userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update password"})
		return
	}

	// remove token after successful reset
	_, _ = config.DB.Exec("DELETE FROM tb_password_resets WHERE token=$1", req.Token)

	c.JSON(http.StatusOK, gin.H{"message": "Password reset successful"})
}
