package controller

import (
	"database/sql"
	"net/http"
	"time"

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

	var userID string
	err := config.DB.QueryRow("SELECT id FROM users WHERE email=$1", req.Email).Scan(&userID)
	if err == sql.ErrNoRows {
		// jangan kasih tau kalau email tidak ada (security reason)
		c.JSON(http.StatusOK, gin.H{"message": "If this email exists, reset link has been sent"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error"})
		return
	}

	token := uuid.New().String()
	expiredAt := time.Now().Add(15 * time.Minute)

	_, err = config.DB.Exec(`
		INSERT INTO password_resets (user_id, token, expired_at) 
		VALUES ($1, $2, $3)
	`, userID, token, expiredAt)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create reset token"})
		return
	}

	// resetURL := os.Getenv("FRONTEND_URL") + "/reset-password?token=" + token
	// println("Reset link:", resetURL)

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
	err := config.DB.QueryRow("SELECT user_id, expired_at FROM password_resets WHERE token=$1", req.Token).
		Scan(&userID, &expiredAt)
	if err == sql.ErrNoRows {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid or expired token"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error"})
		return
	}

	if time.Now().After(expiredAt) {
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

	_, _ = config.DB.Exec("DELETE FROM password_resets WHERE token=$1", req.Token)

	c.JSON(http.StatusOK, gin.H{"message": "Password reset successful"})
}
