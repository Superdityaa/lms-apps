package repositories

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
)

func GetAllCourse() ([]model.Course, error) {
	rows, err := config.DB.Query("SELECT * FROM mt_users")
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
		`INSERT INTO mt_users (coursename, price, category, description)
		VALUES ($1, $2, $3, $4, $5)`,
		course.CourseName, course.Price, course.Category, course.Description,
	)
	return err
}

// Update existing user
func UpdateCourse(id string, course model.Course) error {
	_, err := config.DB.Exec(
		`UPDATE mt_users SET username=$1, email=$2, password=$3, completename=$4, address=$5
		WHERE id=$6`,
		course.CourseName, course.Price, course.Category, course.Description, id,
	)
	return err
}

// Delete user by ID
func DeleteCourse(id string) error {
	_, err := config.DB.Exec("DELETE FROM mt_users WHERE id = $1", id)
	return err
}
