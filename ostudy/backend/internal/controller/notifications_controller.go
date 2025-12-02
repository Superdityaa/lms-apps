package controller

import (
	"fmt"
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
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
	`, id, userID, message, time.Now())
	return err
}

func GetNotifications(c *gin.Context) {
	raw, exists := c.Get("user_id")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "user_id missing in token"})
		return
	}

	userID := fmt.Sprintf("%v", raw)

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

	var notifications []model.Notifications

	for rows.Next() {
		var n model.Notifications
		err := rows.Scan(&n.ID, &n.UserID, &n.Message, &n.CreateOn)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error":   "Scan error",
				"details": err.Error(),
			})
			return
		}
		notifications = append(notifications, n)
	}

	c.JSON(http.StatusOK, gin.H{"notifications": notifications})
}
