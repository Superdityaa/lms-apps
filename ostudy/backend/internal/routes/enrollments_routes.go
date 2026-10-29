package routes

import (
	"lms-apps/backend/internal/controller"

	"github.com/gin-gonic/gin"
)

func SetupEnrollRoutes(r *gin.RouterGroup) {
	r.GET("/getEnroll/:user_id/courses", controller.GetCoursesByUser)
	r.GET("/getEnroll", controller.GetEnrollments)
	r.POST("/createEnroll", controller.EnrollCourse)
	r.DELETE("/unEnroll/:id", controller.DeleteEnrollment)
}
