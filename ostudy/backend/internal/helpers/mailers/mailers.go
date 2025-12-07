package mailers

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"gopkg.in/gomail.v2"
)

func SendEmail(to string, subject string, body string) error {
	smtpHost := os.Getenv("SMTP_HOST")
	smtpPort := 587
	if p := os.Getenv("SMTP_PORT"); p != "" {
		if port, err := strconv.Atoi(p); err == nil {
			smtpPort = port
		} else {
			log.Printf("Invalid SMTP_PORT=%s, using default 587: %v", p, err)
		}
	}
	smtpUser := os.Getenv("SMTP_USER")
	smtpPass := os.Getenv("SMTP_PASSWORD")

	if smtpHost == "" || smtpUser == "" || smtpPass == "" {
		err := fmt.Errorf("smtp configuration missing (SMTP_HOST/SMTP_USER/SMTP_PASSWORD)")
		log.Printf("%v", err)
		return err
	}

	m := gomail.NewMessage()
	m.SetHeader("From", smtpUser)
	m.SetHeader("To", to)
	m.SetHeader("Subject", subject)
	m.SetBody("text/html", body)

	d := gomail.NewDialer(smtpHost, smtpPort, smtpUser, smtpPass)

	if err := d.DialAndSend(m); err != nil {
		log.Printf("Error sending email to %s: %v", to, err)
		return err
	}

	log.Printf("Email sent successfully to %s", to)
	return nil
}
