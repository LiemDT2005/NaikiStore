/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
public class Constants {
    // Google OAuth
    public static final String GOOGLE_CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    public static final String GOOGLE_CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/NaikiStore/loginwithgoogle";
    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static final String GOOGLE_GRANT_TYPE = "authorization_code";

    // Facebook OAuth
    public static final String FACEBOOK_CLIENT_ID = System.getenv("FACEBOOK_CLIENT_ID");
    public static final String FACEBOOK_CLIENT_SECRET = System.getenv("FACEBOOK_CLIENT_SECRET");
    public static final String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/v19.0/oauth/access_token";
    public static final String FACEBOOK_LINK_GET_USER_INFO = "https://graph.facebook.com/me?fields=id,name,email,picture.type(large)&access_token=";
    public static final String FACEBOOK_REDIRECT_URI = "http://localhost:8080/NaikiStore/loginwithfacebook";
}
