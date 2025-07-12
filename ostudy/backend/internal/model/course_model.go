package model

type Course struct {
	ID          string `json:"id"`
	CourseName  string `json:"coursename"`
	Price       int    `json:"price"`
	Category    string `json:"category"`
	Description string `json:"description"`
}
