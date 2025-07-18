package model

type Mentor struct {
	ID          string `json:"id"`
	Avatar      string `json:"avatar"`
	Name        string `json:"name"`
	Role        string `json:"role"`
	Description string `json:"description"`
}
