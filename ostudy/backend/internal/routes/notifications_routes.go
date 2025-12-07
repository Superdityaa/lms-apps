package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupNotifications(r *gin.RouterGroup) {
	r.GET("/getNotifications", middleware.AuthMiddleware(), controller.GetNotifications)
	r.DELETE("/deleteNotifications/:id", middleware.AuthMiddleware(), controller.DeleteNotification)
	r.GET("/getNotificationsByUser/:user_id", middleware.AuthMiddleware(), controller.GetNotificationsByUser)
}
