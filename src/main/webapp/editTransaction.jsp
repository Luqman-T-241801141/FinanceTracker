<%@ page import="java.sql.*" %>
<%@ page import="com.finance.db.DBConnection" %>

<%

int id = Integer.parseInt(request.getParameter("id"));

Connection conn = DBConnection.getConnection();

PreparedStatement ps = conn.prepareStatement(
"SELECT * FROM transactions WHERE id=?");

ps.setInt(1,id);

ResultSet rs = ps.executeQuery();

rs.next();

%>

<html>
<head>

<title>Edit Transaction</title>

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
}

.logo{
font-size:20px;
font-weight:bold;
}

.nav-links a{
margin-left:25px;
text-decoration:none;
color:white;
opacity:0.8;
}

.nav-links a:hover{
opacity:1;
}

/* FORM CONTAINER */

.container{
width:450px;
margin:60px auto;
padding:30px;

border-radius:12px;

background:rgba(255,255,255,0.05);
backdrop-filter:blur(12px);

border:1px solid rgba(255,255,255,0.1);
}

input,select{
width:100%;
padding:12px;
margin-top:6px;
margin-bottom:16px;

border-radius:10px;
border:1px solid rgba(255,255,255,0.15);

background:rgba(255,255,255,0.06);
color:white;
}

button{
width:100%;
padding:12px;
border:none;
border-radius:10px;

background:#3498db;
color:white;
font-size:15px;

cursor:pointer;
}

button:hover{
background:#2980b9;
}

select option{
background:#111827;
color:white;
}

</style>

</head>

<body>

<div class="navbar">

<div class="logo">FinanceTracker</div>

<div class="nav-links">
<a href="dashboard.jsp">Dashboard</a>
<a href="addTransaction.jsp">Add Transaction</a>
<a href="viewTransactions.jsp">View Transactions</a>
<a href="LogoutServlet">Logout</a>
</div>

</div>

<div class="container">

<h2>Edit Transaction</h2>

<form action="UpdateTransactionServlet" method="post">

<input type="hidden" name="id" value="<%= id %>">

<label>Description</label>
<input type="text" name="description"
value="<%= rs.getString("description") %>" required>

<label>Amount</label>
<input type="number" step="0.01" name="amount"
value="<%= rs.getDouble("amount") %>" required>

<label>Category</label>
<input type="text" name="category"
value="<%= rs.getString("category") %>" required>

<label>Date</label>
<input type="date" name="date"
value="<%= rs.getDate("transaction_date") %>" required>

<label>Type</label>

<select name="type">

<option <%= rs.getString("type").equals("Income") ? "selected" : "" %>>
Income
</option>

<option <%= rs.getString("type").equals("Expense") ? "selected" : "" %>>
Expense
</option>

</select>

<button type="submit">Update Transaction</button>

</form>

</div>

</body>
</html>