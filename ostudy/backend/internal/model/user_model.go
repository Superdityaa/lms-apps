package model

type User struct {
	ID           int    `json:"id"`
	Username     string `json:"username"`
	Email        string `json:"email"`
	Password     string `json:"password"`
	Completename string `json:"completename"`
	Address      string `json:"address"`
}
