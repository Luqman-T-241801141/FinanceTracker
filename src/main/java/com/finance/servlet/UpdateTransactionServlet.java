package com.finance.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.finance.db.DBConnection;

@WebServlet("/UpdateTransactionServlet")
public class UpdateTransactionServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

try{

int id = Integer.parseInt(request.getParameter("id"));
String description = request.getParameter("description");
double amount = Double.parseDouble(request.getParameter("amount"));
String category = request.getParameter("category");
String date = request.getParameter("date");
String type = request.getParameter("type");

Connection conn = DBConnection.getConnection();

PreparedStatement ps = conn.prepareStatement(
"UPDATE transactions SET description=?, amount=?, category=?, transaction_date=?, type=? WHERE id=?");

ps.setString(1,description);
ps.setDouble(2,amount);
ps.setString(3,category);
ps.setDate(4, java.sql.Date.valueOf(date));
ps.setString(5,type);
ps.setInt(6,id);

ps.executeUpdate();

response.sendRedirect("viewTransactions.jsp");

}catch(Exception e){
e.printStackTrace();
}

}
}