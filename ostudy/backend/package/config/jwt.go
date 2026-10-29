package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var JWTSecret []byte

// LoadJWTSecret loads the JWT_SECRET from environment variables or falls back to a default for development.
func LoadJWTSecret() []byte {
	_ = godotenv.Load()
	secret := os.Getenv("JWT_SECRET")
	if secret == "" {
		log.Println("WARNING: JWT_SECRET environment variable not set, using default fallback key")
		secret = "SECRET_KEY"
	}
	JWTSecret = []byte(secret)
	return JWTSecret
}

// GetJWTSecret retrieves the cached JWT secret, loading it if not already initialized.
func GetJWTSecret() []byte {
	if len(JWTSecret) == 0 {
		return LoadJWTSecret()
	}
	return JWTSecret
}
