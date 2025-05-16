package routes

import (
    "github.com/gin-gonic/gin"
    "lms-apps/backend/internal/controller"
)

// SetupLoginRoutes - Registers user-related routes with the Gin router.
func SetupLogin(r *gin.RouterGroup) {
    r.POST("/login", controller.Login)
}