package model

import "time"

type User struct {
	ID           string    `json:"id"`
	Avatar       string    `json:"avatar"`
	Username     string    `json:"username"`
	Email        string    `json:"email"`
	Password     string    `json:"password,omitempty"`
	Completename string    `json:"completename"`
	Address      string    `json:"address"`
	Role         string    `json:"role"`
	CreateOn     time.Time `json:"create_on"`
}
