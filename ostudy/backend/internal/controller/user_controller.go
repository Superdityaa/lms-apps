package controller

import (
    "net/http"
    "lms-apps/backend/internal/model"
    "lms-apps/backend/internal/repositories"

    "github.com/gin-gonic/gin"
)

// GetAllUsers
func GetUsers(c *gin.Context) {
    users, err := repositories.GetAllUsers()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve users"})
        return
    }
    c.JSON(http.StatusOK, users)
}

// CreateUser
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

// UpdateUser 
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

// DeleteUser 
func DeleteUser(c *gin.Context) {
    id := c.Param("id")
    err := repositories.DeleteUser(id)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "User deleted successfully"})
}