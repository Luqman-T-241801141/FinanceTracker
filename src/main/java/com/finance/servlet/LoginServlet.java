package com.finance.servlet;

import com.finance.db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int userId = rs.getInt("id");
                String name = rs.getString("name");   // get user's name

                HttpSession session = request.getSession();

                session.setAttribute("userId", userId);
                session.setAttribute("userName", name);   // store name in session

                response.sendRedirect("dashboard.jsp");

            } else {

                // login failed → redirect with error parameter
                response.sendRedirect("login.jsp?error=invalid");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}