package routes

import (
	"lms-apps/backend/internal/controller"

	"github.com/gin-gonic/gin"
)

func SetupUserRoutes(r *gin.RouterGroup) {
	r.GET("/getUser", controller.GetUsers)
	r.POST("/createUser", controller.CreateUser)
	r.PUT("/updateUser:id", controller.UpdateUser)
	r.DELETE("/deleteUser:id", controller.DeleteUser)
}
