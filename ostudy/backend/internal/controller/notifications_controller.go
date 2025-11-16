package controller

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

func CreateNotification(userID int, title, message string) error {
	_, err := config.DB.Exec(`
		INSERT INTO notifications (user_id, message, created_at)
		VALUES ($1, $2, $3)
	`, userID, title, message, false, time.Now())
	return err
}

func GetNotifications(c *gin.Context) {
	userID := c.GetInt("user_id")

	rows, err := config.DB.Query(`
		SELECT id, message, created_at
		FROM notifications
		WHERE user_id = $1
		ORDER BY created_at DESC
	`, userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Can't retrieve notifications!"})
		return
	}
	defer rows.Close()

	var notifications []model.Notifications
	for rows.Next() {
		var n model.Notifications
		rows.Scan(&n.ID, &n.UserID, &n.Message, &n.CreateOn)
		notifications = append(notifications, n)
	}

	c.JSON(http.StatusOK, gin.H{"notifications": notifications})
}
