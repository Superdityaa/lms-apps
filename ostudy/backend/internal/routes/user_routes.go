package routes

import (
    "github.com/gin-gonic/gin"
    "lms-apps/backend/internal/controller"
)

// SetupUserRoutes - Registers user-related routes with the Gin router.
func SetupUserRoutes(r *gin.RouterGroup) {
    r.GET("/", controller.GetUsers)
    r.POST("/", controller.CreateUser)
    r.PUT("/:id", controller.UpdateUser)
    r.DELETE("/:id", controller.DeleteUser)
}