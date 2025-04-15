package config

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var DB *sql.DB

func ConnectDatabase() {
	connStr := "host=localhost port=5432 user=postgres password=YOURPASSWORD dbname=YOURDB sslmode=disable"

	var err error
	DB, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Failed to open a DB connection: ", err)
	}

	err = DB.Ping()
	if err != nil {
		log.Fatal("Failed to connect to DB: ", err)
	}

	fmt.Println("✅ Database connection successful!")
}
