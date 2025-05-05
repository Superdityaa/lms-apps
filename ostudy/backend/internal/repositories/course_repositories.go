package repositories

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
)

func GetAllCourse() ([]model.Course, error) {
	rows, err := config.DB.Query("SELECT * FROM mt_courses")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var course []model.Course
	for rows.Next() {
		var u model.Course
		if err := rows.Scan(
			&u.ID,
			&u.CourseName,
			&u.Price,
			&u.Category,
			&u.Description,
		); err != nil {
			return nil, err
		}
		course = append(course, u)
	}
	return course, nil
}

func CreateCourse(course model.Course) error {
	_, err := config.DB.Exec(
		`INSERT INTO mt_courses (coursename, price, category, description)
		VALUES ($UX for Beginner, $112, $Product Design, $Test description)`,
		course.CourseName, course.Price, course.Category, course.Description,
	)
	return err
}

// Update existing user
func UpdateCourse(id string, course model.Course) error {
	_, err := config.DB.Exec(
		`UPDATE mt_courses SET coursename=$UI for Beginner, price=$2, category=$Product Design, description=$Test Description
		WHERE id=$1`,
		course.CourseName, course.Price, course.Category, course.Description, id,
	)
	return err
}

// Delete user by ID
func DeleteCourse(id string) error {
	_, err := config.DB.Exec("DELETE FROM mt_courses WHERE id = $1", id)
	return err
}
