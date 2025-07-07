package config

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var DB *sql.DB
var TableName string

func ConnectDatabase() {
	connectDB := "host=127.0.0.1 port=5432 user=postgres password=aditcakep08 dbname=ostudy sslmode=disable"
	var err error

	DB, err = sql.Open("postgres", connectDB)
	if err != nil {
		log.Fatal("Error while opening the connection: ", err)
	}

	err = DB.Ping()
	if err != nil {
		log.Fatal("Error while connecting to the database: ", err)
	}

	fmt.Println("Database connection successfully")
}
