package com.finance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.finance.db.DBConnection;

@WebServlet("/AddTransactionServlet")
public class AddTransactionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userId");

            String description = request.getParameter("description");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String category = request.getParameter("category");
            Date date = Date.valueOf(request.getParameter("date"));
            String type = request.getParameter("type");

            Connection conn = DBConnection.getConnection();

            /* -------- GET CURRENT BALANCE -------- */

            double balance = 0;

            String balanceQuery =
                    "SELECT " +
                    "COALESCE(SUM(CASE WHEN type='Income' THEN amount ELSE 0 END),0) - " +
                    "COALESCE(SUM(CASE WHEN type='Expense' THEN amount ELSE 0 END),0) AS balance " +
                    "FROM transactions WHERE user_id=?";

            PreparedStatement psBalance = conn.prepareStatement(balanceQuery);
            psBalance.setInt(1, userId);

            ResultSet rs = psBalance.executeQuery();

            if (rs.next()) {
                balance = rs.getDouble("balance");
            }

            /* -------- BLOCK EXPENSE IF NO BALANCE -------- */

            if (type.equals("Expense") && amount > balance) {
                response.sendRedirect("addTransaction.jsp?error=1");
                return;
            }

            /* -------- INSERT TRANSACTION -------- */

            String sql = "INSERT INTO transactions (user_id, description, amount, category, transaction_date, type) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, description);
            ps.setDouble(3, amount);
            ps.setString(4, category);
            ps.setDate(5, date);
            ps.setString(6, type);

            ps.executeUpdate();

            response.sendRedirect("dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}