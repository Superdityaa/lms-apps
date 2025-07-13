package controller

import (
	helpers "lms-apps/backend/internal/helpers/jwt"
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
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

	// Hashing password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error hashing password"})
		return
	}
	input.Password = string(hashedPassword)

	id := uuid.New()

	_, err = config.DB.Exec(`
		INSERT INTO tb_user (id, username, email, password, completename, address, role)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`, id, input.Username, input.Email, input.Password, input.Completename, input.Address, input.Role)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User registered successfully"})
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
	err := config.DB.QueryRow("SELECT id, email, password, role FROM tb_user WHERE email=$1", input.Email).
		Scan(&user.ID, &user.Email, &user.Password, &user.Role)

	if err != nil {
		println("Query error:", err.Error())
		c.JSON(http.StatusUnauthorized, gin.H{
			"error":   "Invalid email or password",
			"details": err.Error(),
		})
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(input.Password)); err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email or password"})
		return
	}

	// Generate token
	token, err := helpers.GenerateToken(user.ID, user.Role)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Login successful",
		"token":   token,
	})
}
