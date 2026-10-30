package controller

import (
	"database/sql"
	"log"
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
	NewPassword string `json:"new_password"`
	Password    string `json:"password"`
}

// ForgotPasswordHandler handles requesting a password reset email
func ForgotPasswordHandler(c *gin.Context) {
	var req ForgotPasswordRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Valid email is required", "details": err.Error()})
		return
	}

	// Find the user by email
	var userID string
	err := config.DB.QueryRow("SELECT id FROM tb_user WHERE email=$1", req.Email).Scan(&userID)
	if err == sql.ErrNoRows {
		// Return generic success to prevent email enumeration
		c.JSON(http.StatusOK, gin.H{"message": "If this email exists, reset link has been sent"})
		return
	} else if err != nil {
		log.Printf("[ForgotPassword] Database query error: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error"})
		return
	}

	// Remove any previous tokens for this user
	_, _ = config.DB.Exec("DELETE FROM tb_password_resets WHERE user_id=$1", userID)

	// Create a new reset token record (valid for 15 minutes)
	token := uuid.New().String()
	expiredAt := time.Now().Add(15 * time.Minute)
	resetID := uuid.New().String()

	_, err = config.DB.Exec(
		"INSERT INTO tb_password_resets (id, user_id, email, token, expired_at) VALUES ($1, $2, $3, $4, $5)",
		resetID, userID, req.Email, token, expiredAt,
	)
	if err != nil {
		log.Printf("[ForgotPassword] Failed to create reset token: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create reset token"})
		return
	}

	frontend := os.Getenv("FRONTEND_URL")
	if frontend == "" {
		frontend = "http://localhost:3000"
	}
	resetURL := frontend + "/reset-password?token=" + token

	// Generate styled HTML template
	emailBody := mailers.BuildResetPasswordEmail(resetURL, token)

	// Send email asynchronously in background so request does not block
	mailers.SendEmailAsync(req.Email, "Reset Your OStudy Password", emailBody)

	c.JSON(http.StatusOK, gin.H{"message": "If this email exists, reset link has been sent"})
}

// ResetPasswordHandler handles resetting user password with a valid token
func ResetPasswordHandler(c *gin.Context) {
	var req ResetPasswordRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Token is required", "details": err.Error()})
		return
	}

	// Support both 'new_password' and 'password' fields for frontend compatibility
	newPassword := req.NewPassword
	if newPassword == "" {
		newPassword = req.Password
	}

	if len(newPassword) < 6 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Password must be at least 6 characters"})
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
		log.Printf("[ResetPassword] Database error: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error"})
		return
	}

	if time.Now().After(expiredAt) {
		// Delete expired token
		_, _ = config.DB.Exec("DELETE FROM tb_password_resets WHERE token=$1", req.Token)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Token expired"})
		return
	}

	hashedPassword, err := password.HashPassword(newPassword)
	if err != nil {
		log.Printf("[ResetPassword] Hash error: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process password"})
		return
	}

	_, err = config.DB.Exec("UPDATE tb_user SET password=$1 WHERE id=$2", hashedPassword, userID)
	if err != nil {
		log.Printf("[ResetPassword] Update password failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update password"})
		return
	}

	// Invalidate token after successful reset
	_, _ = config.DB.Exec("DELETE FROM tb_password_resets WHERE token=$1", req.Token)

	c.JSON(http.StatusOK, gin.H{"message": "Password reset successful"})
}
