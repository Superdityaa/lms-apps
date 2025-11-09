package controller

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// Get Course
func GetCourse(c *gin.Context) {
	rows, err := config.DB.Query("SELECT * FROM tb_course")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve courses"})
		return
	}
	defer rows.Close()

	var courses []model.Course
	for rows.Next() {
		var course model.Course
		if err := rows.Scan(&course.ID, &course.CourseName, &course.Price, &course.Category, &course.Description, &course.Thumbnail); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning courses", "details": err.Error()})
			return
		}
		courses = append(courses, course)
	}

	c.JSON(http.StatusOK, courses)
}

// Create Course
func CreateCourse(c *gin.Context) {
	var course model.Course
	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	id := uuid.New().String()

	_, err := config.DB.Exec(
		`INSERT INTO tb_course (id, thumbnail, coursename, price, category, description)
         VALUES ($1, $2, $3, $4, $5, $6)`,
		id, course.Thumbnail, course.CourseName, course.Price, course.Category, course.Description,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create course", "details": err.Error()})
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

	_, err := config.DB.Exec(
		`UPDATE tb_course 
         SET  thumbnail=$1, coursename=$2, price=$3, category=$4, description=$5
         WHERE id=$6`,
		course.Thumbnail, course.CourseName, course.Price, course.Category, course.Description, id,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update course", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Course updated successfully"})
}

// Delete Course
func DeleteCourse(c *gin.Context) {
	id := c.Param("id")

	res, err := config.DB.Exec("DELETE FROM tb_course WHERE id = $1", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete course"})
		return
	}

	rowsAffected, _ := res.RowsAffected()
	if rowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Course not found"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Course deleted successfully"})
}
