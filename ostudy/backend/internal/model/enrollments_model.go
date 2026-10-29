package model

import "time"

type Enrollment struct {
	ID           string    `json:"id"`
	UserID       string    `json:"user_id"`
	Completename string    `json:"completename"`
	CourseID     string    `json:"course_id"`
	CourseName   string    `json:"coursename"`
	EnrolledOn   time.Time `json:"enrolled_on"`
}
