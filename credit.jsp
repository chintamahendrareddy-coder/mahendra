<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="dbconnect.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Credit Money</title>
<style>
  body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #e8f5e9, #f1f8e9);
    text-align: center;
  }

  h2 {
    color: #2e7d32;
    margin-top: 40px;
    font-size: 28px;
  }

  form {
    background: white;
    padding: 25px;
    width: 360px;
    margin: 40px auto;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  }

  input {
    width: 90%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
  }

  button {
    background: #43a047;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
  }

  button:hover {
    background: #2e7d32;
    transform: scale(1.05);
  }

  a {
    color: #2e7d32;
    text-decoration: none;
    display: block;
    margin-top: 20px;
    font-weight: bold;
  }

  a:hover {
    color: #1b5e20;
  }

  p {
    font-size: 16px;
  }
</style>
</head>
<body>

<h2>💰 Credit Money</h2>

<form method="post">
  <input type="text" name="customer_id" placeholder="Customer ID" required><br>
  <input type="number" name="amount" placeholder="Amount (₹)" required><br>
  <button type="submit">Credit</button>
</form>

<a href="home.jsp">🏠 Back to Home</a>

<%
if (request.getMethod().equalsIgnoreCase("POST")) {
    String cid = request.getParameter("customer_id");
    double amt = Double.parseDouble(request.getParameter("amount"));
    try {
        PreparedStatement ps = conn.prepareStatement("UPDATE customers SET balance = balance + ? WHERE customer_id = ?");
        ps.setDouble(1, amt);
        ps.setString(2, cid);
        int updated = ps.executeUpdate();
        if (updated > 0)
            out.println("<p style='color:green;'>✅ Credited &#8377;" + String.format("%.2f", amt) + " successfully!</p>");
        else
            out.println("<p style='color:red;'>❌ Customer not found!</p>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
}
%>

</body>
</html>
