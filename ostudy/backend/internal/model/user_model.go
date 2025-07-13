package model

type User struct {
	ID           string `json:"id"`
	Username     string `json:"username"`
	Email        string `json:"email"`
	Password     string `json:"password,omitempty"`
	Completename string `json:"completename"`
	Address      string `json:"address"`
	Role         string `json:"role"`
}
