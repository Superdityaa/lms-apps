package routes

import (
	"lms-apps/backend/internal/controller"
	"lms-apps/backend/internal/helpers/middleware"

	"github.com/gin-gonic/gin"
)

func SetupUserRoutes(r *gin.RouterGroup) {
	r.GET("/getUser", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.GetUsers)
	r.POST("/createUser", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.CreateUser)
	r.PUT("/updateUser/:id", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.UpdateUser)
	r.DELETE("/deleteUser/:id", middleware.AuthMiddleware(), middleware.RoleAuthorization("superadmin"), controller.DeleteUser)
}
