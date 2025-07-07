package routes

import (
	"lms-apps/backend/internal/controller"

	"github.com/gin-gonic/gin"
)

func SetupCourseRoutes(r *gin.RouterGroup) {
	r.GET("/getCourse", controller.GetCourse)
	r.POST("/createCourse", controller.CreateCourse)
	r.PUT("/updateCourse:id", controller.UpdateCourse)
	r.DELETE("/deleteCourse:id", controller.DeleteCourse)
}
