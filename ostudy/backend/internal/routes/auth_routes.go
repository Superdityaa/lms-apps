package routes

import (
	"lms-apps/backend/internal/controller"
	"github.com/gin-gonic/gin"
)

func SetupAuthRoutes(r *gin.RouterGroup) {
	r.POST("/register", controller.Register)
	r.POST("/login", controller.Login)
}