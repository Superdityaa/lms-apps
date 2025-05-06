package main

import (
	"fmt"
	"lms-apps/backend/internal/repositories"
	"lms-apps/backend/internal/routes"
	"lms-apps/backend/package/config"

	"github.com/gin-gonic/gin"
)

// func main() {
// 	config.ConnectDatabase()

// 	users, err := repositories.GetAllUsers()
// 	if err != nil {
// 		fmt.Println("Error getting users:", err)
// 		return
// 	}

// 	for _, u := range users {
// 		fmt.Printf(
// 			"ID: %d, Username: %s, Email: %s\n",
// 			"Password: %s\n",
// 			"Completename: %s\n",
// 			"Address: %s\n",
// 			u.ID,
// 			u.Username,
// 			u.Email,
// 			u.Password,
// 			u.Completename,
// 			u.Address,
// 		)
// 	}
// }

func main() {
	config.ConnectDatabase()

	courses, err := repositories.GetAllCourse()
	if err != nil {
		fmt.Println("Error getting courses:", err)
		return
	}

	for _, u := range courses {
		fmt.Printf(
			"ID: %d, CourseName: %s, Price: %s\n",
			"Category: %s\n",
			"Description: %s\n",
			u.ID,
			u.CourseName,
			u.Price,
			u.Category,
			u.Description,
		)
	}
}

func baseUrl() {
	config.ConnectDatabase()

	r := gin.Default()
	api := r.Group("/api")

	routes.SetupCourseRoutes(api.Group("/courses"))

	r.Run(":8080")
}
