package controller

import (
	"lms-apps/backend/internal/helpers/password"
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"

	"github.com/gin-gonic/gin"
)

// GetAllUsers
func GetUsers(c *gin.Context) {
	rows, err := config.DB.Query("SELECT * FROM tb_user")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve users"})
		return
	}
	defer rows.Close()

	var users []model.User
	for rows.Next() {
		var u model.User
		if err := rows.Scan(&u.ID, &u.Avatar, &u.Username, &u.Email, &u.Password, &u.Completename, &u.Address); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error scanning users"})
			return
		}
		users = append(users, u)
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

	hashedPassword, err := password.HashPassword(user.Password)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to hash password"})
		return
	}

	_, err = config.DB.Exec(
		`INSERT INTO tb_user (avatar, username, email, password, completename, address, role)
         VALUES ($1, $2, $3, $4, $5, $6, $7)`,
		user.Avatar, user.Username, user.Email, hashedPassword, user.Completename, user.Address, user.Role,
	)
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

	hashedPassword := user.Password
	if user.Password != "" {
		var err error
		hashedPassword, err = password.HashPassword(user.Password)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to hash password"})
			return
		}
	}

	_, err := config.DB.Exec(
		`UPDATE tb_user SET avatar=$1, username=$2, email=$3, password=$4, completename=$5, address=$6, role=$7 WHERE id=$8`,
		user.Avatar, user.Username, user.Email, hashedPassword, user.Completename, user.Address, user.Role, id,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User updated successfully"})
}

// DeleteUser
func DeleteUser(c *gin.Context) {
	id := c.Param("id")
	_, err := config.DB.Exec("DELETE FROM tb_user WHERE id = $1", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User deleted successfully"})
}
