<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="dbconnect.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Customers</title>
<style>
body { 
  font-family: 'Poppins', sans-serif;
  text-align: center;
  margin: 0;
  background-image: url('https://www.shutterstock.com/image-vector/internet-network-business-connecting-people-600nw-2462914425.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  color: #fff;
}

/* Floating Title */
h2 { 
  margin-top: 20px;
  background: rgba(0, 77, 128, 0.85);
  color: #fff;
  display: inline-block;
  padding: 15px 40px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.4);
  letter-spacing: 1px;
  font-size: 28px;
  font-weight: 600;
  text-shadow: 2px 2px 5px rgba(0,0,0,0.4);
}

/* Table styling */
table {
  margin: 60px auto;
  border-collapse: collapse;
  width: 90%;
  background: rgba(0, 0, 0, 0.6);
  box-shadow: 0 8px 25px rgba(0,0,0,0.5);
  border-radius: 15px;
  overflow: hidden;
  color: white;
}

/* Header row */
th {
  background: linear-gradient(90deg, rgba(0,188,212,0.9), rgba(0,77,128,0.9));
  color: #fff;
  padding: 15px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Table rows */
td {
  padding: 12px;
  border-bottom: 1px solid rgba(255,255,255,0.1);
}

tr:nth-child(even) {
  background: rgba(255,255,255,0.08);
}

tr:hover {
  background: rgba(255,255,255,0.15);
  transition: 0.3s;
}

/* Back button */
a.button {
  text-decoration: none;
  color: white;
  font-weight: bold;
  background: linear-gradient(90deg, #004d80, #00bcd4);
  padding: 10px 20px;
  border-radius: 10px;
  transition: 0.3s;
  display: inline-block;
  box-shadow: 0 4px 10px rgba(0,0,0,0.3);
}
a.button:hover {
  background: linear-gradient(90deg, #00bcd4, #004d80);
  transform: scale(1.05);
}

/* Delete button */
a.delete-btn {
  text-decoration: none;
  color: #fff;
  background: linear-gradient(90deg, #d32f2f, #b71c1c);
  padding: 8px 15px;
  border-radius: 8px;
  transition: 0.3s;
}
a.delete-btn:hover {
  background: linear-gradient(90deg, #b71c1c, #d32f2f);
  transform: scale(1.05);
}
</style>
</head>
<body>

<h2>👥 All Customers</h2>

<table>
<tr>
  <th>Customer ID</th><th>Name</th><th>Age</th><th>Gender</th><th>CIBIL</th>
  <th>Loan</th><th>Paid</th><th>Remaining</th><th>Balance</th><th>Action</th>
</tr>

<%
try {
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM customers");
    while(rs.next()) {
        String status = rs.getString("loan_status");
        double loan = rs.getDouble("loan_amount");
        double paid = rs.getDouble("loan_paid");
        double remain = loan - paid;

        out.println("<tr>");
        out.println("<td>"+rs.getString("customer_id")+"</td>");
        out.println("<td>"+rs.getString("name")+"</td>");
        out.println("<td>"+rs.getInt("age")+"</td>");
        out.println("<td>"+rs.getString("gender")+"</td>");
        out.println("<td>"+rs.getInt("civil_score")+"</td>");

        if ("APPROVED".equalsIgnoreCase(status) && loan > 0) {
            out.println("<td>&#8377;" + String.format("%.2f", loan) + "</td>");
            out.println("<td>&#8377;" + String.format("%.2f", paid) + "</td>");
            out.println("<td>&#8377;" + String.format("%.2f", remain) + "</td>");
        } else {
            out.println("<td>—</td><td>—</td><td>—</td>");
        }

        out.println("<td>&#8377;" + String.format("%.2f", rs.getDouble("balance")) + "</td>");

        // ✅ Delete button with confirmation
        out.println("<td><a class='delete-btn' href='deleteCustomer.jsp?id="+rs.getString("customer_id")+"' onclick='return confirm(\"Are you sure you want to delete this customer?\");'>Delete</a></td>");
        
        out.println("</tr>");
    }
} catch(Exception e) {
    out.println("<tr><td colspan='10' style='color:red;'>Error: "+e.getMessage()+"</td></tr>");
}
%>
</table>

<p><a href="home.jsp" class="button">🏠 Back to Home</a></p>

</body>
</html>
