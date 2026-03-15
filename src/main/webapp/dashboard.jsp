<%@ page import="java.sql.*" %>
<%@ page import="com.finance.db.DBConnection" %>
<%@ page session="true" %>

<%
String name = (String) session.getAttribute("userName");
int userId = (int) session.getAttribute("userId");

Connection conn = DBConnection.getConnection();

double totalIncome = 0;
double totalExpense = 0;

PreparedStatement ps1 = conn.prepareStatement(
"SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='Income'");
ps1.setInt(1, userId);
ResultSet rs1 = ps1.executeQuery();
if(rs1.next()) totalIncome = rs1.getDouble(1);

PreparedStatement ps2 = conn.prepareStatement(
"SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='Expense'");
ps2.setInt(1, userId);
ResultSet rs2 = ps2.executeQuery();
if(rs2.next()) totalExpense = rs2.getDouble(1);

double balance = totalIncome - totalExpense;
%>
<%
PreparedStatement ps3 = conn.prepareStatement(
"SELECT EXTRACT(MONTH FROM transaction_date) AS month, SUM(amount) " +
"FROM transactions WHERE user_id=? AND type='Expense' " +
"GROUP BY month ORDER BY month");

ps3.setInt(1, userId);
ResultSet rs3 = ps3.executeQuery();

double[] monthly = new double[12];

while(rs3.next()){
    int m = rs3.getInt("month") - 1;
    monthly[m] = rs3.getDouble("sum");
}
%>
<html>
<head>
<title>Dashboard</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

/* MAIN CONTAINER */

.container{
width:900px;
margin:50px auto;
}

/* CARDS */

.cards{
display:flex;
gap:20px;
margin-bottom:40px;
}

.card{
flex:1;
padding:30px;
border-radius:12px;
text-align:center;
font-size:18px;
backdrop-filter:blur(10px);
background:rgba(255,255,255,0.05);
border:1px solid rgba(255,255,255,0.1);
transition:0.3s;
}

.card:hover{
transform:translateY(-5px);
}

.income{
border-left:5px solid #2ecc71;
}

.expense{
border-left:5px solid #e74c3c;
}

.balance{
border-left:5px solid #3498db;
}

.card h3{
margin-bottom:10px;
}

.amount{
font-size:26px;
font-weight:bold;
}

/* CHART */

canvas{
background:white;
border-radius:12px;
padding:20px;
}
</style>

</head>
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
<body>

<div class="container">

<h2>Welcome, <%= name %> </h2>

<div class="cards">

<div class="card income">
<h3>Total Income</h3>
<div class="amount">INR <%= totalIncome %></div>
</div>

<div class="card expense">
<h3>Total Expense</h3>
<div class="amount">INR <%= totalExpense %></div>
</div>

<div class="card balance">
<h3>Balance</h3>
<div class="amount">INR <%= balance %></div>
</div>

</div>

<br><br>

<h3>Expense Chart</h3>

<canvas id="expenseChart"></canvas>
<h3>Monthly Expenses</h3>

<canvas id="monthlyChart"></canvas>
</div>

<script>

const data = {
labels: ['Income', 'Expense'],
datasets: [{
data: [<%= totalIncome %>, <%= totalExpense %>],
backgroundColor: [
'#2ecc71',
'#e74c3c'
]
}]
};

const config = {
type: 'doughnut',
data: data
};

new Chart(
document.getElementById('expenseChart'),
config
);
const monthlyData = {
		labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		datasets: [{
		label: 'Expenses',
		data: [
		<%= monthly[0] %>,
		<%= monthly[1] %>,
		<%= monthly[2] %>,
		<%= monthly[3] %>,
		<%= monthly[4] %>,
		<%= monthly[5] %>,
		<%= monthly[6] %>,
		<%= monthly[7] %>,
		<%= monthly[8] %>,
		<%= monthly[9] %>,
		<%= monthly[10] %>,
		<%= monthly[11] %>
		],
		backgroundColor:'#e74c3c'
		}]
		};

		new Chart(
		document.getElementById('monthlyChart'),
		{
		type:'bar',
		data:monthlyData
		});
</script>

</body>

</html>
