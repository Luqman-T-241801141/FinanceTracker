<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>FinanceTracker - Login</title>

<style>

/* Reset */

*{
box-sizing:border-box;
margin:0;
padding:0;
}

/* Body */

body{
font-family: Arial, sans-serif;
background:#0f1117;
height:100vh;

display:flex;
justify-content:center;
align-items:center;

color:white;
}

/* Main layout */

.page{
display:flex;
align-items:center;
gap:120px;
}

/* Left intro section */

.intro{
max-width:420px;
}

.intro h1{
font-size:40px;
margin-bottom:15px;
}

.subtitle{
font-size:16px;
opacity:0.7;
margin-bottom:25px;
}

.features{
list-style:none;
opacity:0.8;
}

.features li{
margin-bottom:12px;
font-size:15px;
}

/* Login card */

.container{

width:380px;
padding:40px;

border-radius:14px;

background:rgba(255,255,255,0.05);
backdrop-filter:blur(12px);

border:1px solid rgba(255,255,255,0.1);

box-shadow:0 10px 30px rgba(0,0,0,0.6);
}

/* Title */

.title{
text-align:center;
font-size:22px;
font-weight:bold;
margin-bottom:5px;
}

.tagline{
text-align:center;
font-size:13px;
opacity:0.7;
margin-bottom:30px;
}

/* Labels */

label{
font-size:14px;
opacity:0.9;
}

/* Inputs */

input{

width:100%;
padding:12px;
margin-top:6px;
margin-bottom:18px;

border-radius:10px;
border:1px solid rgba(255,255,255,0.15);

background:rgba(255,255,255,0.06);
color:white;

outline:none;
transition:0.2s;
}

/* Input focus */

input:focus{
border:1px solid #3b82f6;
box-shadow:0 0 8px rgba(59,130,246,0.4);
}

/* Button */

button{

width:100%;
padding:12px;

border:none;
border-radius:10px;

background:linear-gradient(135deg,#3b82f6,#2563eb);
color:white;

font-size:15px;
font-weight:bold;

cursor:pointer;
transition:0.3s;
}

/* Button hover */

button:hover{
transform:translateY(-2px);
box-shadow:0 8px 20px rgba(37,99,235,0.4);
}

/* Register link */

.register{

text-align:center;
margin-top:20px;
font-size:14px;
opacity:0.8;
}

.register a{
color:#3b82f6;
text-decoration:none;
}

.register a:hover{
text-decoration:underline;
}

/* Footer */

.footer{
position:fixed;
bottom:20px;
font-size:12px;
opacity:0.5;
}
.alert{
color:#ff6b6b;
background:rgba(255,0,0,0.08);
padding:8px;
border-radius:6px;
font-size:13px;
margin-top:-10px;
margin-bottom:10px;
}
</style>

</head>

<body>

<div class="page">

<!-- Left Side -->

<div class="intro">

<h1>FinanceTracker</h1>

<p class="subtitle">
A simple web application to manage personal income and expenses.
</p>

<ul class="features">

<li>Track your income and expenses easily</li>
<li>View financial summaries on the dashboard</li>
<li>Visualize spending with charts</li>
<li>Manage transactions securely</li>

</ul>

</div>

<!-- Login Card -->

<div class="container">

<div class="title">Login</div>
<div class="tagline">Access your finance dashboard</div>

<form action="LoginServlet" method="post">

<label>Email</label>
<input type="text" name="email" required>

<label>Password</label>
<input type="password" name="password" required>
<%
String error = request.getParameter("error");
if("invalid".equals(error)){
%>

<div class="alert">
Invalid email or password. Please try again.
</div>

<%
}
%>
<button type="submit">Login</button>

</form>

<div class="register">
Don't have an account? <a href="register.jsp">Create one</a>
</div>

</div>

</div>

<div class="footer">
FinanceTracker - Personal Finance Web App
</div>

</body>
</html>