/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Random;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class PasswordUtils {
    // Mã hóa mật khẩu với bcrypt
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12)); // Tạo salt với độ phức tạp 12
    }

    // Kiểm tra mật khẩu
    public static boolean checkPassword(String password, String hashedPassword) {
        return BCrypt.checkpw(password, hashedPassword);
    }

    // Các ký tự có thể sử dụng để tạo mật khẩu
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    public static String generateSimplePassword(int length) {
        Random random = new Random();
        StringBuilder password = new StringBuilder(length);

        // Sinh chuỗi ngẫu nhiên
        for (int i = 0; i < length; i++) {
            password.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }

        return password.toString();
    }
}
