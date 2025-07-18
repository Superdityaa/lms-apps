package controller

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// Get Mentor
func GetMentors(c *gin.Context) {
	rows, err := config.DB.Query("SELECT * FROM tb_mentor")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve users"})
		return
	}
	defer rows.Close()

	var users []model.Mentor
	for rows.Next() {
		var u model.Mentor
		if err := rows.Scan(&u.ID, &u.Avatar, &u.Name, &u.Role, &u.Description); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning users"})
			return
		}
		users = append(users, u)
	}
	c.JSON(http.StatusOK, users)
}

// Create Mentor
func CreateMentor(c *gin.Context) {
	var mentor model.Mentor
	if err := c.ShouldBindJSON(&mentor); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}
	id := uuid.New().String()

	_, err := config.DB.Exec(
		`INSERT INTO tb_mentor (id, avatar, name, role, description)
         VALUES ($1, $2, $3, $4, $5)`,
		id, mentor.Avatar, mentor.Name, mentor.Role, mentor.Description,
	)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create mentor", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Mentor created successfully"})
}

// Update Mentor
func UpdateMentor(c *gin.Context) {
	id := c.Param("id")
	var mentor model.Mentor
	if err := c.ShouldBindJSON(&mentor); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	_, err := config.DB.Exec(
		`UPDATE tb_mentor SET avatar=$1, name=$2, role=$3, description=$4 WHERE id=$5`,
		mentor.Avatar, mentor.Name, mentor.Role, mentor.Description, id,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update mentor"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "mentor updated successfully"})
}

// Delete Mentor
func DeleteMentor(c *gin.Context) {
	id := c.Param("id")
	_, err := config.DB.Exec("DELETE FROM tb_mentor WHERE id = $1", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User deleted successfully"})
}
