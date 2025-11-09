package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupEnrollRoutes(r *gin.RouterGroup) {
	r.GET("getEnroll/:user_id/courses", middleware.AuthMiddleware(), controller.GetCoursesByUser)
	r.GET("/getEnroll", middleware.AuthMiddleware(), controller.GetEnrollments)
	r.POST("/createEnroll", middleware.AuthMiddleware(), controller.EnrollCourse)
	r.DELETE("/unEnroll/:id", middleware.AuthMiddleware(), controller.DeleteEnrollment)
}
