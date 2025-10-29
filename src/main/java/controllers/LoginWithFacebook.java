/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import utils.Constants;
import utils.MailUtil;
import utils.PasswordUtils;

/**
 *
 * @author Do Ho Gia Huy - CE191293
 */
@WebServlet(name = "LoginWithFacebook", urlPatterns = {"/loginwithfacebook"})
public class LoginWithFacebook extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String code = request.getParameter("code");
            if (code == null || code.isEmpty()) {
                response.getWriter().write("Missing Facebook authorization code.");
                return;
            }
            String accessToken = getToken(code);
            if (accessToken == null || accessToken.isEmpty()) {
                response.getWriter().write("Failed to get access token from Facebook.");
                return;
            }
            Customer userFromFacebook = getUserInfo(accessToken);
            // Nếu không lấy được email từ Facebook, chuyển hướng về trang đăng nhập
            if (userFromFacebook == null || userFromFacebook.getEmail() == null) {
                response.getWriter().write("Failed to get user info from Facebook.");
                return;
            }

            CustomersDAO udao = new CustomersDAO();
            HttpSession session = request.getSession();

            Customer userInDB = udao.getUserByEmail(userFromFacebook.getEmail());

            if (userInDB != null) {
                // Nếu tài khoản đã tồn tại -> login
                session.setAttribute("loggedUser", userInDB);
            } else {
                // Nếu chưa có tài khoản -> tạo mới
                String randomPassword = PasswordUtils.generateSimplePassword(8);
                String hashedPassword = PasswordUtils.hashPassword(randomPassword);

                Customer newUser = new Customer();
                newUser.setCustomerId(udao.createCustomerID());
                newUser.setCustomerName(userFromFacebook.getCustomerName());
                newUser.setEmail(userFromFacebook.getEmail());
                newUser.setPassword(hashedPassword);
                newUser.setGender(Customer.Gender.OTHER);
                newUser.setAvatar(userFromFacebook.getAvatar());
                newUser.setStatus(Customer.Status.ACTIVE);
                udao.registerUserAPI(newUser);

                MailUtil.sendMail(newUser.getEmail(), randomPassword);
                session.setAttribute("user", newUser);
            }

            response.sendRedirect("home");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Facebook Login failed");
            request.getRequestDispatcher("/login").forward(request, response);
        }

    }

    public static String getToken(String code) throws IOException {

        String response = Request.Post(Constants.FACEBOOK_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", Constants.FACEBOOK_CLIENT_ID)
                                .add("client_secret", Constants.FACEBOOK_CLIENT_SECRET)
                                .add("redirect_uri", Constants.FACEBOOK_REDIRECT_URI)
                                .add("code", code)
                                .build()
                )
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");

        return accessToken;

    }

    public static Customer getUserInfo(final String accessToken) throws IOException {

        String link = Constants.FACEBOOK_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(link).execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        Customer user = new Customer();
        user.setCustomerName(jobj.get("name").getAsString());
        user.setEmail(jobj.get("email").getAsString());
        if (jobj.has("picture")) {
            JsonObject pictureObj = jobj.getAsJsonObject("picture");
            if (pictureObj.has("data")) {
                JsonObject dataObj = pictureObj.getAsJsonObject("data");
                if (dataObj.has("url")) {
                    user.setAvatar(dataObj.get("url").getAsString());
                } else {
                    user.setAvatar("login/defaultAvatar.png");
                }
            } else {
                user.setAvatar("login/defaultAvatar.png");
            }
        } else {
            user.setAvatar("login/defaultAvatar.png");
        }

        return user;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Facebook OAuth2 Login Servlet";
    }// </editor-fold>

}
