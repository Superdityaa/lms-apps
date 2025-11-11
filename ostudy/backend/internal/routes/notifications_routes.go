package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupNotifications(r *gin.RouterGroup) {
	r.GET("/getNotifications", middleware.AuthMiddleware(), controller.GetNotifications)
}
