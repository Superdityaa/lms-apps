package model

import "time"

type Mentor struct {
	ID          string    `json:"id"`
	Avatar      string    `json:"avatar"`
	Name        string    `json:"name"`
	Role        string    `json:"role"`
	Description string    `json:"description"`
	CreateOn    time.Time `json:"create_on"`
}
