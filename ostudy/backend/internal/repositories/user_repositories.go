package repositories

import (
	"lms-apps/backend/package/config"
	"lms-apps/backend/internal/model"
)


func GetAllUsers() ([]model.User, error) {
	rows, err := config.DB.Query("SELECT * FROM mt_users")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []model.User
	for rows.Next() {
		var u model.User
		if err := rows.Scan(
			&u.ID,
			&u.Username,
			&u.Email,
			&u.Password,
			&u.Completename,
			&u.Address,
		); err != nil {
			return nil, err
		}
		users = append(users, u)
	}
	return users, nil
}
