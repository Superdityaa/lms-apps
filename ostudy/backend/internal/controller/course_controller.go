package controller

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/internal/repositories"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Get Course
func GetCourse(c *gin.Context) {
	course, err := repositories.GetAllCourse()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve courses"})
		return
	}
	c.JSON(http.StatusOK, course)
}

// Create Course
func CreateCourse(c *gin.Context) {
	var course model.Course
	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	err := repositories.CreateCourse(course)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create course"})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"message": "Course created successfully"})
}

// Update Course
func UpdateCourse(c *gin.Context) {
	id := c.Param("id")
	var course model.Course
	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	err := repositories.UpdateCourse(id, course)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update course"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Course updated successfully"})
}

// Delete Course
func DeleteCourse(c *gin.Context) {
	id := c.Param("id")
	err := repositories.DeleteCourse(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "User deleted successfully"})
}
