package main

import (
	"lms-apps/backend/internal/helpers/middleware"
	"lms-apps/backend/internal/routes"
	"lms-apps/backend/package/config"

	"github.com/gin-gonic/gin"
)

func main() {
	// 1. Connect DB
	config.ConnectDatabase()

	// 2. Setup router
	r := gin.Default()

	// 3. Setup routes
	api := r.Group("/api")

	// Public routes (no auth)
	routes.SetupAuthRoutes(api)

	// Protected routes
	protected := api.Group("")
	protected.Use(middleware.AuthMiddleware())
	routes.SetupCourseRoutes(protected)
	routes.SetupUserRoutes(protected)
	routes.SetupMentorRoutes(protected)

	// 4. Run server
	r.Run(":8080")
}

// func main() {
// 	r := gin.Default()

// 	r.GET("/", func(c *gin.Context) {
// 		c.JSON(200, gin.H{
// 			"message": "pong",
// 		})
// 	})
// 	r.Run()
// }
