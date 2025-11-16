package model

import "time"

type Notifications struct {
	ID       string    `json:"id"`
	UserID   string    `json:"user_id"`
	Message  string    `json:"message"`
	CreateOn time.Time `json:"create_on"`
}
