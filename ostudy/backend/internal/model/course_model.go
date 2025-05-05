package model

type Course struct {
	ID          int    `json:"id"`
	CourseName  string `json:"coursename"`
	Price       int    `json:"price"`
	Category    string `json:"category"`
	Description string `json:"description"`
}
