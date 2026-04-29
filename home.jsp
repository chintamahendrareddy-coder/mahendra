<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp" %>
<%
if(session.getAttribute("admin") == null){
    response.sendRedirect("index.jsp");
}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>
body { 
  font-family:'Poppins', sans-serif; 
  margin:0; 
  text-align:center; 
  background-image: url('https://img.freepik.com/free-vector/digital-money-transfer-technology-background_1017-17454.jpg?semt=ais_hybrid&w=740&q=80');
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  background-repeat: no-repeat;
  color: white;
}

/* Unified header + nav look */
header { 
  background: linear-gradient(90deg, rgba(0,77,128,0.9), rgba(0,188,212,0.9));
  color:white; 
  padding:25px 0 10px 0; 
  font-size:28px; 
  letter-spacing:1px; 
  box-shadow: 0 4px 15px rgba(0,0,0,0.3);
  border-bottom-left-radius: 15px;
  border-bottom-right-radius: 15px;
}

/* Navigation bar directly attached below header */
nav {
  background: rgba(0, 77, 128, 0.85);
  padding: 15px 0;
  border-bottom-left-radius: 15px;
  border-bottom-right-radius: 15px;
  width: 100%;
  box-shadow: 0 4px 10px rgba(0,0,0,0.3);
  margin-top: 0; /* 🔥 removes gap between title and nav */
}

/* Navigation links */
nav a {
  display:inline-block; 
  margin:10px; 
  padding:12px 20px;
  background: linear-gradient(90deg, #00bcd4, #004d80);
  color:white; 
  text-decoration:none; 
  border-radius:10px; 
  font-weight:bold;
  transition:0.3s;
  box-shadow: 0 3px 6px rgba(0,0,0,0.3);
}

nav a:hover { 
  background: linear-gradient(90deg, #004d80, #00bcd4); 
  transform:scale(1.05); 
}

/* Logout button with red tone */
nav a.logout {
  background: linear-gradient(90deg, #ff5252, #c62828);
}

nav a.logout:hover {
  background: linear-gradient(90deg, #c62828, #ff5252);
}
</style>
</head>
<body>
<header>
  🏦 Welcome, Admin
</header>

<nav>
  <a href="addCustomer.jsp">➕ Add Customer</a>
  <a href="credit.jsp">💰 Credit</a>
  <a href="debit.jsp">💸 Debit</a>
  <a href="viewCustomers.jsp">👥 View Customers</a>
  <a href="payLoan.jsp">💳 Pay Loan</a>
  <a href="logout.jsp" class="logout">🚪 Logout</a>
</nav>

</body>
</html>
