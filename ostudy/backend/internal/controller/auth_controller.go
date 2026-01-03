package controller

import (
	"lms-apps/backend/internal/helpers/jwt"
	"lms-apps/backend/internal/helpers/password"
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// Register user
func Register(c *gin.Context) {
	var input model.User
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input", "details": err.Error()})
		return
	}

	if input.Email == "" || input.Password == "" || input.Username == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Email, username, and password are required"})
		return
	}
	if input.Role == "" {
		input.Role = "student"
	}

	var exists bool
	err := config.DB.QueryRow(
		"SELECT EXISTS(SELECT 1 FROM tb_user WHERE email = $1)",
		input.Email,
	).Scan(&exists)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Database error",
		})
		return
	}

	if exists {
		c.JSON(http.StatusConflict, gin.H{
			"error": "Email already registered",
		})
		return
	}

	// Hashing password
	hashedPassword, err := password.HashPassword(input.Password)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error hashing password"})
		return
	}
	input.Password = hashedPassword

	id := uuid.New()

	_, err = config.DB.Exec(`
		INSERT INTO tb_user (id, username, email, password, completename, address, role)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`, id, input.Username, input.Email, input.Password, input.Completename, input.Address, input.Role)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message": "User registered successfully",
		"user": gin.H{
			"id":           id,
			"username":     input.Username,
			"email":        input.Email,
			"role":         input.Role,
			"completename": input.Completename,
			"address":      input.Address,
		},
	})
}

// Login user
func Login(c *gin.Context) {
	var input model.User
	if err := c.ShouldBindJSON(&input); err != nil {
		// Debug log
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   "Invalid input",
			"details": err.Error(),
		})
		return
	}

	var user model.User
	err := config.DB.QueryRow("SELECT id, username, email, password, completename, address, role FROM tb_user WHERE email=$1", input.Email).
		Scan(&user.ID, &user.Username, &user.Email, &user.Password, &user.Completename, &user.Address, &user.Role)
	println("Role in DB:", user.Role)

	if err != nil {
		println("Query error:", err.Error())
		c.JSON(http.StatusUnauthorized, gin.H{
			"error":   "Invalid email or password",
			"details": err.Error(),
		})
		return
	}

	if err := password.CheckPassword(user.Password, input.Password); err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email or password"})
		return
	}

	// Generate token
	token, err := jwt.GenerateToken(user.ID, user.Role)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Login successful",
		"token":   token,
		"role":    user.Role,
		"user": gin.H{
			"id":           user.ID,
			"username":     user.Username,
			"email":        user.Email,
			"completename": user.Completename,
			"address":      user.Address,
		},
	},
	)
}
