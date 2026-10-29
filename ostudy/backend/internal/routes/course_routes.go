package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupCourseRoutes(r *gin.RouterGroup) {
	r.GET("/getCourse", controller.GetCourse)
	r.POST("/createCourse", middleware.RoleAuthorization("mentor", "superadmin"), controller.CreateCourse)
	r.PUT("/updateCourse/:id", middleware.RoleAuthorization("mentor", "superadmin"), controller.UpdateCourse)
	r.DELETE("/deleteCourse/:id", middleware.RoleAuthorization("mentor", "superadmin"), controller.DeleteCourse)
}
