package controller

import (
	"fmt"
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"log"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func CreateNotification(userID string, message string) error {
	id := uuid.New().String()
	_, err := config.DB.Exec(`
		INSERT INTO tb_notifications (id, user_id, message, created_at)
		VALUES ($1, $2, $3, $4)
	`, id, userID, message, time.Now().UTC())
	return err
}

func GetNotifications(c *gin.Context) {
	raw, exists := c.Get("user_id")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "user_id missing in token"})
		return
	}

	userID := fmt.Sprintf("%v", raw)
	log.Printf("GetNotifications: token user_id=%s", userID)

	rows, err := config.DB.Query(`
		SELECT id, user_id, message, created_at
		FROM tb_notifications
		WHERE user_id = $1
		ORDER BY created_at DESC
	`, userID)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "Can't retrieve notifications!",
			"details": err.Error(),
		})
		return
	}
	defer rows.Close()

	notifications := make([]model.Notifications, 0)

	for rows.Next() {
		var n model.Notifications
		err := rows.Scan(&n.ID, &n.UserID, &n.Message, &n.CreatedAt)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error":   "Scan error",
				"details": err.Error(),
			})
			return
		}
		notifications = append(notifications, n)
	}

	if err := rows.Err(); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "Error iterating notifications",
			"details": err.Error(),
		})
		return
	}

	log.Printf("GetNotifications: returning %d notifications for user_id=%s", len(notifications), userID)
	c.JSON(http.StatusOK, gin.H{"notifications": notifications})
}

// DeleteNotification
func DeleteNotification(c *gin.Context) {
	raw, exists := c.Get("user_id")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "user_id missing in token"})
		return
	}

	userID := fmt.Sprintf("%v", raw)
	id := c.Param("id")
	if id == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "notification id required"})
		return
	}

	result, err := config.DB.Exec(`
		DELETE FROM tb_notifications WHERE id = $1 AND user_id = $2
	`, id, userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete notification", "details": err.Error()})
		return
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"message": "Notification not found or not owned by user"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Notification deleted", "id": id})
}

// GetNotificationsByUser
func GetNotificationsByUser(c *gin.Context) {
	userID := c.Param("user_id")
	if userID == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "user_id required"})
		return
	}

	rows, err := config.DB.Query(`
		SELECT id, user_id, message, created_at
		FROM tb_notifications
		WHERE user_id = $1
		ORDER BY created_at DESC
	`, userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Can't retrieve notifications!", "details": err.Error()})
		return
	}
	defer rows.Close()

	notifications := make([]model.Notifications, 0)
	for rows.Next() {
		var n model.Notifications
		if err := rows.Scan(&n.ID, &n.UserID, &n.Message, &n.CreatedAt); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Scan error", "details": err.Error()})
			return
		}
		notifications = append(notifications, n)
	}

	if err := rows.Err(); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating notifications", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"notifications": notifications})
}
