package routes

import (
	"lms-apps/backend/internal/controller"

	"github.com/gin-gonic/gin"
)

func SetupNotifications(r *gin.RouterGroup) {
	r.GET("/getNotifications", controller.GetNotifications)
	r.DELETE("/deleteNotifications/:id", controller.DeleteNotification)
	r.GET("/getNotificationsByUser/:user_id", controller.GetNotificationsByUser)
}
