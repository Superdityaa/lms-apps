package model

import "time"

type Enrollment struct {
	ID         string    `json:"id"`
	UserID     string    `json:"user_id"`
	CourseID   string    `json:"course_id"`
	EnrolledAt time.Time `json:"enrolled_at"`
}
