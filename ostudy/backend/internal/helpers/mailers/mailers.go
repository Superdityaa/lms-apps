package mailers

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"gopkg.in/gomail.v2"
)

// SendEmail sends an HTML email synchronously.
func SendEmail(to string, subject string, htmlBody string) error {
	smtpHost := os.Getenv("SMTP_HOST")
	smtpPort := 587
	if p := os.Getenv("SMTP_PORT"); p != "" {
		if port, err := strconv.Atoi(p); err == nil {
			smtpPort = port
		} else {
			log.Printf("[Mailer] Invalid SMTP_PORT=%s, defaulting to 587: %v", p, err)
		}
	}
	smtpUser := os.Getenv("SMTP_USER")
	smtpPass := os.Getenv("SMTP_PASSWORD")
	senderName := os.Getenv("SMTP_SENDER_NAME")
	if senderName == "" {
		senderName = "OStudy LMS"
	}

	if smtpHost == "" || smtpUser == "" || smtpPass == "" {
		err := fmt.Errorf("[Mailer] SMTP configuration missing (SMTP_HOST/SMTP_USER/SMTP_PASSWORD)")
		log.Printf("%v", err)
		return err
	}

	m := gomail.NewMessage()
	m.SetAddressHeader("From", smtpUser, senderName)
	m.SetHeader("To", to)
	m.SetHeader("Subject", subject)
	m.SetBody("text/html", htmlBody)

	d := gomail.NewDialer(smtpHost, smtpPort, smtpUser, smtpPass)

	if err := d.DialAndSend(m); err != nil {
		log.Printf("[Mailer] Error sending email to %s: %v", to, err)
		return err
	}

	log.Printf("[Mailer] Email sent successfully to %s", to)
	return nil
}

// SendEmailAsync sends an HTML email in a background goroutine to prevent blocking HTTP handlers.
func SendEmailAsync(to string, subject string, htmlBody string) {
	go func() {
		defer func() {
			if r := recover(); r != nil {
				log.Printf("[Mailer] Recovered from panic in SendEmailAsync: %v", r)
			}
		}()

		if err := SendEmail(to, subject, htmlBody); err != nil {
			log.Printf("[Mailer] Background email dispatch failed for %s: %v", to, err)
		}
	}()
}

// BuildResetPasswordEmail generates a responsive HTML email template for password reset.
func BuildResetPasswordEmail(resetURL, token string) string {
	return fmt.Sprintf(
		`<!DOCTYPE html>
			<html>
			<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Reset Password - OStudy</title>
			</head>
			<body style="margin: 0; padding: 24px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #f1f5f9;">
			<table width="100%%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<td align="center">
					<table width="100%%" border="0" cellspacing="0" cellpadding="0" style="max-width: 540px; background-color: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);">
					<tr>
						<td style="background-color: #1e40af; padding: 28px 24px; text-align: center;">
						<h1 style="margin: 0; color: #ffffff; font-size: 24px; font-weight: 700; letter-spacing: 0.5px;">OStudy LMS</h1>
						</td>
					</tr>
					<tr>
						<td style="padding: 32px 28px; color: #334155; font-size: 15px; line-height: 1.6;">
						<p style="margin-top: 0;">Halo,</p>
						<p>Kami menerima permintaan untuk mereset kata sandi akun OStudy Anda. Silakan klik tombol di bawah untuk melanjutkan:</p>
						
						<div style="text-align: center; margin: 30px 0;">
							<a href="%s" style="background-color: #2563eb; color: #ffffff; padding: 12px 30px; text-decoration: none; border-radius: 8px; font-weight: 600; font-size: 15px; display: inline-block;">Reset Kata Sandi</a>
						</div>

						<p style="font-size: 13px; color: #64748b; margin-bottom: 6px;">Jika Anda menggunakan aplikasi mobile, gunakan token berikut untuk mereset password Anda:</p>
						<div style="background-color: #f8fafc; border: 1px dashed #cbd5e1; border-radius: 8px; padding: 12px; text-align: center; font-family: monospace; font-size: 14px; font-weight: bold; color: #0f172a; word-break: break-all;">
							%s
						</div>

						<p style="font-size: 12px; color: #dc2626; margin-top: 24px;">
							<strong>Perhatian:</strong> Tautan dan token ini hanya berlaku selama <strong>15 menit</strong>. Jika Anda tidak meminta perubahan kata sandi, abaikan email ini.
						</p>
						</td>
					</tr>
					<tr>
						<td style="background-color: #f8fafc; padding: 16px 24px; text-align: center; font-size: 12px; color: #94a3b8; border-top: 1px solid #f1f5f9;">
						&copy; OStudy LMS. Semua hak cipta dilindungi.
						</td>
					</tr>
					</table>
				</td>
				</tr>
			</table>
			</body>
			</html>`,
		resetURL, token)
}
