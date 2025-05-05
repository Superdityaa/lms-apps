package routes

import (
    "github.com/gin-gonic/gin"
    "lms-apps/backend/internal/controller"
)

// SetupUserRoutes - Registers user-related routes with the Gin router.
func SetupCourseRoutes(r *gin.RouterGroup) {
    r.GET("/", controller.GetCourse)
    r.POST("/", controller.CreateCourse)
    r.PUT("/:id", controller.UpdateCourse)
    r.DELETE("/:id", controller.DeleteCourse)
}