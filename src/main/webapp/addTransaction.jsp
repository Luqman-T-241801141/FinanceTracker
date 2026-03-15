<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Add Transaction</title>

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
width:450px;
margin:60px auto;
padding:30px;
border-radius:12px;

backdrop-filter:blur(10px);
background:rgba(255,255,255,0.05);
border:1px solid rgba(255,255,255,0.1);
}

h2{
text-align:center;
margin-bottom:25px;
}

label{
font-size:14px;
color:#cbd5f5;
}

/* INPUTS */

input,select{
width:100%;
padding:12px;
margin-top:6px;
margin-bottom:16px;

border-radius:10px;
border:1px solid rgba(255,255,255,0.15);

background:rgba(255,255,255,0.06);
color:white;
outline:none;
}

/* SELECT */

select{
appearance:none;
-webkit-appearance:none;

background-image:url("data:image/svg+xml;utf8,<svg fill='white' height='24' viewBox='0 0 24 24' width='24'><path d='M7 10l5 5 5-5z'/></svg>");
background-repeat:no-repeat;
background-position:right 10px center;
background-size:18px;
}

select option{
background:#111827;
color:white;
}

input:focus,select:focus{
border:1px solid #3b82f6;
box-shadow:0 0 10px rgba(59,130,246,0.4);
}

/* BUTTON */

button{
margin-top:10px;
padding:12px;
width:100%;

border:none;
border-radius:10px;

background:linear-gradient(135deg,#3b82f6,#2563eb);
color:white;
font-size:15px;
font-weight:600;

cursor:pointer;
transition:0.3s;
}

button:hover{
transform:translateY(-2px);
box-shadow:0 8px 20px rgba(37,99,235,0.4);
}

/* ERROR MESSAGE */

.error{
color:#ff6b6b;
background:rgba(255,0,0,0.08);
padding:10px;
border-radius:8px;
margin-bottom:15px;
text-align:center;
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

<h2>💳 Add Transaction</h2>

<%
String error = request.getParameter("error");
if(error != null){
%>

<div class="error">
Insufficient balance. You cannot add this expense.
</div>

<%
}
%>

<form action="AddTransactionServlet" method="post">

<label>Description</label>
<input type="text" name="description" required>

<label>Amount</label>
<input type="number" step="0.01" name="amount" required>

<label>Category</label>

<select name="category" required>

<option value="">Select Category</option>

<option value="Salary">Income - Salary</option>
<option value="Freelance">Income - Freelance</option>
<option value="Business">Income - Business</option>
<option value="Other Income">Income - Other Income</option>

<option value="Food">Expense - Food</option>
<option value="Transport">Expense - Transport</option>
<option value="Shopping">Expense - Shopping</option>
<option value="Bills">Expense - Bills</option>
<option value="Entertainment">Expense - Entertainment</option>
<option value="Health">Expense - Health</option>
<option value="Education">Expense - Education</option>
<option value="Other Expense">Expense - Other Expense</option>

</select>

<label>Date</label>
<input type="date" name="date" required>

<label>Type</label>
<select name="type">
<option value="Income">Income</option>
<option value="Expense">Expense</option>
</select>

<button type="submit">Add Transaction</button>

</form>

</div>

</body>
</html>