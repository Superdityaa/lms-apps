package controller

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// Get all enrollments
func GetEnrollments(c *gin.Context) {
	rows, err := config.DB.Query("SELECT id, user_id, course_id, enrolled_on FROM tb_enrollment")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve enrollments", "details": err.Error()})
		return
	}
	defer rows.Close()

	var enrollments []model.Enrollment
	for rows.Next() {
		var e model.Enrollment
		if err := rows.Scan(&e.ID, &e.UserID, &e.CourseID, &e.EnrolledOn); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning enrollments", "details": err.Error()})
			return
		}
		enrollments = append(enrollments, e)
	}

	c.JSON(http.StatusOK, enrollments)
}

// Enroll a user to a course
func EnrollCourse(c *gin.Context) {
	var req struct {
		UserID   string `json:"user_id" binding:"required"`
		CourseID string `json:"course_id" binding:"required"`
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	// Check if already enrolled
	var exists bool
	err := config.DB.QueryRow(
		"SELECT EXISTS(SELECT 1 FROM tb_enrollment WHERE user_id=$1 AND course_id=$2)",
		req.UserID, req.CourseID,
	).Scan(&exists)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check enrollment", "details": err.Error()})
		return
	}

	if exists {
		c.JSON(http.StatusConflict, gin.H{"message": "User already enrolled in this course"})
		return
	}

	// Insert enrollment record
	enrollID := uuid.New().String()
	_, err = config.DB.Exec(
		`INSERT INTO tb_enrollment (user_id, course_id, enrolled_on)
		 VALUES ($1, $2, $3)`,
		enrollID, req.UserID, req.CourseID, time.Now(),
	)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to enroll user", "details": err.Error()})
		return
	}

	var courseName, completeName string

	err = config.DB.QueryRow(`
		SELECT c.coursename, u.completename
		FROM tb_course c
		JOIN tb_user u ON u.id = $1
		WHERE c.id = $2
	`, req.UserID, req.CourseID).Scan(&courseName, &completeName)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch user/course info", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Enrollment successful",
		"enrollment_id": enrollID,
		"user_id":       req.UserID,
		"course_id":     req.CourseID,
		"coursename":    courseName,
		"completename":  completeName})

}

// Get courses by user
func GetCoursesByUser(c *gin.Context) {
	userID := c.Param("user_id")

	rows, err := config.DB.Query(`
		SELECT c.id, c.thumbnail, c.coursename, c.price, c.category, c.description
		FROM tb_course c
		JOIN tb_enrollment e ON c.id = e.course_id
		WHERE e.user_id = $1`, userID)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve user's courses", "details": err.Error()})
		return
	}
	defer rows.Close()

	var courses []model.Course
	for rows.Next() {
		var course model.Course
		if err := rows.Scan(&course.ID, &course.Thumbnail, &course.CourseName, &course.Price, &course.Category, &course.Description); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning courses", "details": err.Error()})
			return
		}
		courses = append(courses, course)
	}

	c.JSON(http.StatusOK, courses)
}

// Delete enrollment (Unenroll)
func DeleteEnrollment(c *gin.Context) {
	id := c.Param("id")

	result, err := config.DB.Exec("DELETE FROM tb_enrollment WHERE id=$1", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to unenroll user", "details": err.Error()})
		return
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"message": "Enrollment not found"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "User unenrolled successfully",
		"id":      id,
	})
}
