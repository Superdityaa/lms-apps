package repositories

import (
	"lms-apps/backend/internal/model"
	"lms-apps/backend/package/config"
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

func CreateUser(user model.User) error {
	_, err := config.DB.Exec(
		`INSERT INTO mt_users (username, email, password, completename, address)
		 VALUES ($1, $2, $3, $4, $5)`,
		user.Username, user.Email, user.Password, user.Completename, user.Address,
	)
	return err
}

// Update existing user
func UpdateUser(id string, user model.User) error {
	_, err := config.DB.Exec(
		`UPDATE mt_users SET username=$1, email=$2, password=$3, completename=$4, address=$5
		 WHERE id=$6`,
		user.Username, user.Email, user.Password, user.Completename, user.Address, id,
	)
	return err
}

// Delete user by ID
func DeleteUser(id string) error {
	_, err := config.DB.Exec("DELETE FROM mt_users WHERE id = $1", id)
	return err
}
