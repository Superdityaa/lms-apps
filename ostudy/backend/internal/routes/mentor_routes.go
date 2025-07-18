package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupMentorRoutes(r *gin.RouterGroup) {
	r.GET("/getMentor", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.GetMentors)
	r.POST("/createMentor", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.CreateMentor)
	r.PUT("/updateMentor/:id", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.UpdateMentor)
	r.DELETE("/deleteMentor/:id", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.DeleteMentor)
}
