package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupCourseRoutes(r *gin.RouterGroup) {
	r.GET("/getCourse", middleware.AuthMiddleware(), controller.GetCourse)
	r.POST("/createCourse", middleware.AuthMiddleware(), middleware.RoleAuthorization("mentor", "superadmin"), controller.CreateCourse)
	r.PUT("/updateCourse/:id", middleware.AuthMiddleware(), middleware.RoleAuthorization("mentor", "superadmin"), controller.UpdateCourse)
	r.DELETE("/deleteCourse/:id", middleware.AuthMiddleware(), middleware.RoleAuthorization("mentor", "superadmin"), controller.DeleteCourse)
}
