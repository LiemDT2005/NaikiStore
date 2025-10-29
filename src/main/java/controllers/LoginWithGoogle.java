/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import dao.CustomersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import models.Customer;
import utils.Constants;
import utils.MailUtil;
import utils.PasswordUtils;

@WebServlet(name = "LoginWithGoogle", urlPatterns = {"/loginwithgoogle"})
public class LoginWithGoogle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String code = request.getParameter("code");
            if (code == null || code.isEmpty()) {
                response.getWriter().write("Missing Google authorization code.");
                return;
            }

            String accessToken = getToken(code);
            if (accessToken == null || accessToken.isEmpty()) {
                response.getWriter().write("Failed to get access token from Google.");
                return;
            }

            Customer userFromGoogle = getUserInfo(accessToken);
            if (userFromGoogle == null || userFromGoogle.getEmail() == null) {
                response.getWriter().write("Failed to get user info from Google.");
                return;
            }

            CustomersDAO udao = new CustomersDAO();
            HttpSession session = request.getSession();

            Customer userInDB = udao.getUserByEmail(userFromGoogle.getEmail());

            if (userInDB != null) {
                // Nếu tài khoản đã tồn tại -> login
                session.setAttribute("loggedUser", userInDB);
            } else {
                // Nếu chưa có tài khoản -> tạo mới
                String randomPassword = PasswordUtils.generateSimplePassword(8);
                String hashedPassword = PasswordUtils.hashPassword(randomPassword);

                Customer newUser = new Customer();
                newUser.setCustomerId(udao.createCustomerID());
                newUser.setCustomerName(userFromGoogle.getCustomerName());
                newUser.setEmail(userFromGoogle.getEmail());
                newUser.setPassword(hashedPassword);
                newUser.setGender(Customer.Gender.OTHER);
                newUser.setAvatar(userFromGoogle.getAvatar());
                newUser.setStatus(Customer.Status.ACTIVE);
                udao.registerUserAPI(newUser);

                MailUtil.sendMail(newUser.getEmail(), randomPassword);
                session.setAttribute("user", newUser);

            }

            response.sendRedirect("home");

        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi chi tiết
            request.setAttribute("errorMessage", "Google Login failed.");
            request.getRequestDispatcher("/login").forward(request, response);
        }
    }

    public static String getToken(String code) throws IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE)
                        .build())
                .execute()
                .returnContent()
                .asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        if (jobj.has("error")) {
            return null;
        }
        return jobj.get("access_token").getAsString();
    }

    public static Customer getUserInfo(final String accessToken) throws IOException {
        String response = Request.Get(Constants.GOOGLE_LINK_GET_USER_INFO + accessToken)
                .execute()
                .returnContent()
                .asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        Customer user = new Customer();
        user.setCustomerName(jobj.get("name").getAsString());
        user.setEmail(jobj.get("email").getAsString());
        if (jobj.has("picture") && !jobj.get("picture").isJsonNull()) {
            user.setAvatar(jobj.get("picture").getAsString());
        } else {
            //  Nếu không có avatar từ Google, đặt mặc định
            user.setAvatar("login/defaultAvatar.png");
        }

        return user;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Google OAuth2 Login Servlet";
    }
}
