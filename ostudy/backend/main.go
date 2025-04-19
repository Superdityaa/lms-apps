package main

import (
	"fmt"
	"lms-apps/backend/internal/repositories"
	"lms-apps/backend/package/config"
)

func main() {
	config.ConnectDatabase()

	users, err := repositories.GetAllUsers()
	if err != nil {
		fmt.Println("Error getting users:", err)
		return
	}

	for _, u := range users {
		fmt.Printf("ID: %d, Username: %s, Email: %s\n", "Password: %s\n", "Completename: %s\n", "Address: %s\n",
			u.ID, u.Username, u.Email, u.Password, u.Completename, u.Address)
	}
}
