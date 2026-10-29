package controller

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"time"

	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// Get all enrollments
func GetEnrollments(c *gin.Context) {
	rows, err := config.DB.Query(`
		SELECT 
			e.id, 
			e.user_id, 
			COALESCE(u.completename, '') AS completename, 
			e.course_id, 
			COALESCE(c.coursename, '') AS coursename, 
			e.enrolled_on
		FROM tb_enrollment e
		LEFT JOIN tb_user u ON e.user_id = u.id
		LEFT JOIN tb_course c ON e.course_id = c.id
		ORDER BY e.enrolled_on DESC
	`)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve enrollments", "details": err.Error()})
		return
	}
	defer rows.Close()

	var enrollments []model.Enrollment
	for rows.Next() {
		var e model.Enrollment
		if err := rows.Scan(&e.ID, &e.UserID, &e.Completename, &e.CourseID, &e.CourseName, &e.EnrolledOn); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning enrollments", "details": err.Error()})
			return
		}
		enrollments = append(enrollments, e)
	}

	if err := rows.Err(); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating enrollments", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, enrollments)
}

// Enroll a user to a course
func EnrollCourse(c *gin.Context) {
	rawUserID, exists := c.Get("user_id")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Unauthorized, user_id missing in token"})
		return
	}
	userID := fmt.Sprintf("%v", rawUserID)

	var req struct {
		CourseID string `json:"course_id" binding:"required"`
		UserID   string `json:"user_id"`
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "course_id is required"})
		return
	}

	var courseName string
	err := config.DB.QueryRow("SELECT coursename FROM tb_course WHERE id = $1", req.CourseID).Scan(&courseName)
	if err == sql.ErrNoRows {
		c.JSON(http.StatusNotFound, gin.H{"error": "Course not found"})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check course", "details": err.Error()})
		return
	}

	var completeName string
	err = config.DB.QueryRow("SELECT completename FROM tb_user WHERE id = $1", userID).Scan(&completeName)
	if err != nil && err != sql.ErrNoRows {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch user info", "details": err.Error()})
		return
	}

	var alreadyEnrolled bool
	err = config.DB.QueryRow(
		"SELECT EXISTS(SELECT 1 FROM tb_enrollment WHERE user_id=$1 AND course_id=$2)",
		userID, req.CourseID,
	).Scan(&alreadyEnrolled)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check enrollment", "details": err.Error()})
		return
	}

	if alreadyEnrolled {
		c.JSON(http.StatusConflict, gin.H{"message": "User already enrolled in this course"})
		return
	}

	enrollID := uuid.New().String()
	enrolledOn := time.Now().UTC()
	_, err = config.DB.Exec(
		`INSERT INTO tb_enrollment (id, user_id, course_id, enrolled_on)
		 VALUES ($1, $2, $3, $4)`,
		enrollID, userID, req.CourseID, enrolledOn,
	)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to enroll user", "details": err.Error()})
		return
	}

	notifMsg := "Anda berhasil membeli course baru!"
	if err := CreateNotification(userID, notifMsg); err != nil {
		log.Printf("CreateNotification failed for user %s: %v", userID, err)

	}

	c.JSON(http.StatusCreated, gin.H{
		"message":      "Enrollment successful",
		"id":           enrollID,
		"user_id":      userID,
		"completename": completeName,
		"course_id":    req.CourseID,
		"coursename":   courseName,
		"enrolled_on":  enrolledOn,
	})
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

	if err := rows.Err(); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iterating courses", "details": err.Error()})
		return
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
