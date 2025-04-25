package controller

import (
    "net/http"
    "lms-apps/backend/internal/model"
    "lms-apps/backend/internal/repositories"

    "github.com/gin-gonic/gin"
)

// GetUsers - Handles GET /users endpoint to retrieve all users.
func GetUsers(c *gin.Context) {
    users, err := repositories.GetAllUsers()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve users"})
        return
    }
    c.JSON(http.StatusOK, users)
}

// CreateUser - Handles POST /users endpoint to create a new user.
func CreateUser(c *gin.Context) {
    var user model.User
    if err := c.ShouldBindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
        return
    }

    err := repositories.CreateUser(user)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create user"})
        return
    }
    c.JSON(http.StatusCreated, gin.H{"message": "User created successfully"})
}

// UpdateUser - Handles PUT /users/:id endpoint to update a user.
func UpdateUser(c *gin.Context) {
    id := c.Param("id")
    var user model.User
    if err := c.ShouldBindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
        return
    }

    err := repositories.UpdateUser(id, user)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "User updated successfully"})
}

// DeleteUser - Handles DELETE /users/:id endpoint to delete a user.
func DeleteUser(c *gin.Context) {
    id := c.Param("id")
    err := repositories.DeleteUser(id)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "User deleted successfully"})
}