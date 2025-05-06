package routes

import (
	"lms-apps/backend/internal/controller"

	"github.com/gin-gonic/gin"
)

// SetupUserRoutes - Registers user-related routes with the Gin router.
func SetupCourseRoutes(r *gin.RouterGroup) {
	r.GET("/courses", controller.GetCourse)
	r.POST("/addcourses", controller.CreateCourse)
	r.PUT("/:id", controller.UpdateCourse)
	r.DELETE("/:id", controller.DeleteCourse)
}
