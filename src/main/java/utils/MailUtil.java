/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class MailUtil {

    public static void sendOtp(String toEmail, String otpCode) throws MessagingException {
        final String fromEmail = "naikivietnam@gmail.com"; // Email gửi đi
        final String password = "uenh bott qoqo cgwx";     // App password (không phải mật khẩu Gmail)

        // Cấu hình mail server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP của Gmail
        props.put("mail.smtp.port", "587");            // Port TLS
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // Tạo nội dung mail
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
                Message.RecipientType.TO, InternetAddress.parse(toEmail)
        );
        message.setSubject("OTP Code for Password Reset");
        String logoUrl = "https://drive.google.com/uc?export=view&id=1U8TpmiyKHmc-MS17Asdp0ToFuwAFMz9s";

        String htmlContent = "<!DOCTYPE html>"
                + "<html><head><meta charset='UTF-8'></head>"
                + "<body style='margin:0;padding:0;background-color:#f5f5f5;'>"
                + "<table width='100%' cellpadding='0' cellspacing='0' style='background-color:#f5f5f5;padding: 20px 0;'>"
                + "  <tr><td align='center'>"
                + "    <table width='600' style='background-color:white;border-radius:8px;padding:30px;font-family:sans-serif;'>"
                + "      <tr><td align='center' style='padding-bottom:20px;'>"
                + "        <img src='" + logoUrl + "' alt='Naiki Logo' height='50'/>"
                + "      </td></tr>"
                + "      <tr><td style='font-size:16px;color:#333;'>"
                + "        <p>Dear <b>" + toEmail.split("@")[0] + "</b>,</p>"
                + "        <p>You have requested to change your password.</p>"
                + "        <p style='font-size:18px;'>Please enter the verification code:</p>"
                + "        <p style='font-size:26px;font-weight:bold;color:#d32f2f;letter-spacing:2px;text-align:center;'>"
                + otpCode + "</p>"
                + "        <p>This code will expire in <b>15 minutes</b>.</p>"
                + "        <p>If this was not requested by you, please contact our "
                + "<a href='https://www.instagram.com/naikivietnam/'>customer service</a>.</p>"
                + "        <p style='color:#888;font-size:13px;'>"
                + "          This is a computer-generated email. Please do not reply."
                + "        </p>"
                + "        <p style='margin-top:30px;'>Best regards,<br>NAIKI VIETNAM</p>"
                + "<p style='margin-top:30px; color: #888; font-size: 13px; white-space: normal; line-height: 1.5;'>"
                + "&copy; 2025 NAIKI VIETNAM Co., Ltd. All rights reserved.<br>"
                + "Head Office: Alpha Tower, Can Tho<br>"
                + "Phone: 1800 0000 <br>"
                + "Email: <a href='mailto:naikivietnam@gmail.com'>naikivietnam@gmail.com</a>"
                + "</p>"
                + "      </td></tr>"
                + "    </table>"
                + "  </td></tr>"
                + "</table>"
                + "</body></html>";

        message.setContent(htmlContent, "text/html; charset=utf-8");

        // Gửi mail
        Transport.send(message);
    }
    public static void sendMail(String toEmail, String Code) throws MessagingException {
        final String fromEmail = "naikivietnam@gmail.com"; // Email gửi đi
        final String password = "uenh bott qoqo cgwx";     // App password (không phải mật khẩu Gmail)

        // Cấu hình mail server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP của Gmail
        props.put("mail.smtp.port", "587");            // Port TLS
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // Tạo nội dung mail
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
                Message.RecipientType.TO, InternetAddress.parse(toEmail)
        );
        message.setSubject("Account Created Successfully!");
        String logoUrl = "https://drive.google.com/uc?export=view&id=1U8TpmiyKHmc-MS17Asdp0ToFuwAFMz9s";

        String htmlContent = "<!DOCTYPE html>"
                + "<html><head><meta charset='UTF-8'></head>"
                + "<body style='margin:0;padding:0;background-color:#f5f5f5;'>"
                + "<table width='100%' cellpadding='0' cellspacing='0' style='background-color:#f5f5f5;padding: 20px 0;'>"
                + "  <tr><td align='center'>"
                + "    <table width='600' style='background-color:white;border-radius:8px;padding:30px;font-family:sans-serif;'>"
                + "      <tr><td align='center' style='padding-bottom:20px;'>"
                + "        <img src='" + logoUrl + "' alt='Naiki Logo' height='50'/>"
                + "      </td></tr>"
                + "      <tr><td style='font-size:16px;color:#333;'>"
                + "        <p>Dear <b>" + toEmail.split("@")[0] + "</b>,</p>"
                + "        <p style='font-size:18px;'>Your account has been created. Password:</p>"
                + "        <p style='font-size:26px;font-weight:bold;color:#d32f2f;letter-spacing:2px;text-align:center;'>"
                + Code + "</p>"
                + "        <p>If this was not requested by you, please contact our "
                + "<a href='https://www.instagram.com/naikivietnam/'>customer service</a>.</p>"
                + "        <p style='color:#888;font-size:13px;'>"
                + "          This is a computer-generated email. Please do not reply."
                + "        </p>"
                + "        <p style='margin-top:30px;'>Best regards,<br>NAIKI VIETNAM</p>"
                + "<p style='margin-top:30px; color: #888; font-size: 13px; white-space: normal; line-height: 1.5;'>"
                + "&copy; 2025 NAIKI VIETNAM Co., Ltd. All rights reserved.<br>"
                + "Head Office: Alpha Tower, Can Tho<br>"
                + "Phone: 1800 0000 <br>"
                + "Email: <a href='mailto:naikivietnam@gmail.com'>naikivietnam@gmail.com</a>"
                + "</p>"
                + "      </td></tr>"
                + "    </table>"
                + "  </td></tr>"
                + "</table>"
                + "</body></html>";

        message.setContent(htmlContent, "text/html; charset=utf-8");

        // Gửi mail
        Transport.send(message);
    }
}
