<%@ page import="java.sql.*" %>
<%@ page import="com.finance.db.DBConnection" %>
<%@ page session="true" %>

<html>
<head>
<title>Transaction History</title>

<style>

body{
font-family:Arial;
background:#0f1117;
color:white;
margin:0;
}

/* NAVBAR */

.navbar{
display:flex;
justify-content:space-between;
align-items:center;
padding:15px 40px;
background:rgba(255,255,255,0.05);
backdrop-filter:blur(12px);
border-bottom:1px solid rgba(255,255,255,0.1);
position:sticky;
top:0;
}

.logo{
font-size:20px;
font-weight:bold;
}

.nav-links a{
margin-left:25px;
text-decoration:none;
color:white;
font-size:15px;
opacity:0.8;
transition:0.2s;
}

.nav-links a:hover{
opacity:1;
}

/* CONTAINER */

.container{
width:900px;
margin:50px auto;
padding:30px;

border-radius:12px;

background:rgba(255,255,255,0.05);
backdrop-filter:blur(12px);

border:1px solid rgba(255,255,255,0.1);
}

h2{
text-align:center;
margin-bottom:25px;
}

/* TABLE */

table{
width:100%;
border-collapse:collapse;
}

th{
padding:12px;
text-align:left;
border-bottom:1px solid rgba(255,255,255,0.1);
}

td{
padding:12px;
border-bottom:1px solid rgba(255,255,255,0.05);
}

tr:hover{
background:rgba(255,255,255,0.05);
}

/* AMOUNT COLORS */

.income{
color:#2ecc71;
font-weight:bold;
}

.expense{
color:#e74c3c;
font-weight:bold;
}

/* BUTTONS */

.action-btn{
text-decoration:none;
padding:6px 12px;
border-radius:6px;
font-size:13px;
}

.edit{
background:#3498db;
color:white;
}

.edit:hover{
background:#2980b9;
}

.delete{
background:#e74c3c;
color:white;
}

.delete:hover{
background:#c0392b;
}

</style>

</head>

<body>

<div class="navbar">

<div class="logo">
FinanceTracker
</div>

<div class="nav-links">
<a href="dashboard.jsp">Dashboard</a>
<a href="addTransaction.jsp">Add Transaction</a>
<a href="viewTransactions.jsp">View Transactions</a>
<a href="LogoutServlet">Logout</a>
</div>

</div>

<div class="container">

<h2> Transaction History</h2>

<table>

<tr>
<th>Date</th>
<th>Description</th>
<th>Category</th>
<th>Amount</th>
<th>Type</th>
<th>Actions</th>
</tr>

<%

int userId = (int) session.getAttribute("userId");

Connection conn = DBConnection.getConnection();

String sql = "SELECT * FROM transactions WHERE user_id=? ORDER BY transaction_date DESC";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1,userId);

ResultSet rs = ps.executeQuery();

while(rs.next()){

String type = rs.getString("type");

%>

<tr>

<td><%= rs.getDate("transaction_date") %></td>

<td><%= rs.getString("description") %></td>

<td><%= rs.getString("category") %></td>

<td class="<%= type.equals("Income") ? "income" : "expense" %>">
INR <%= rs.getDouble("amount") %>
</td>

<td><%= type %></td>

<td>

<a class="action-btn edit"
href="editTransaction.jsp?id=<%= rs.getInt("id") %>">
Edit
</a>

<a class="action-btn delete"
href="DeleteTransactionServlet?id=<%= rs.getInt("id") %>">
Delete
</a>

</td>

</tr>

<%
}
%>

</table>

</div>

</body>
</html>