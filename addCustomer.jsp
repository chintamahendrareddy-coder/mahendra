<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="dbconnect.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Customer</title>
<style>
body {
  font-family: 'Poppins', sans-serif;
  background-image: url('https://www.shutterstock.com/image-photo/stock-market-forex-trading-graph-600nw-2345047121.jpg');
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  background-repeat: no-repeat;
  text-align: center;
  color: #333;
}

/* Form box */
form {
  background: rgba(255, 255, 255, 0.95);
  padding: 25px;
  width: 440px;
  margin: 60px auto;
  border-radius: 15px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.3);
}

/* Input fields */
input, select, textarea {
  width: 90%;
  padding: 12px;
  margin: 10px 0;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-size: 15px;
  resize: none;
}

/* Buttons */
button {
  background: linear-gradient(90deg, #00bfa5, #00695c);
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: 0.3s;
}
button:hover {
  background: linear-gradient(90deg, #00695c, #00bfa5);
  transform: scale(1.05);
}

/* Back link */
a {
  display: block;
  margin-top: 20px;
  color: #00695c;
  text-decoration: none;
  font-weight: bold;
}
a:hover {
  text-decoration: underline;
}
</style>
</head>
<body>

<h2 style="color:white; text-shadow:1px 1px 5px rgba(0,0,0,0.7);">➕ Add New Customer</h2>

<form method="post">
  <input type="text" name="customer_id" placeholder="Customer ID" required>
  <input type="text" name="name" placeholder="Full Name" required>
  <input type="text" name="father_name" placeholder="Father's Name" required>
  <input type="text" name="mother_name" placeholder="Mother's Name" required>

  <input type="number" name="age" placeholder="Age (Above 18)" min="19" max="118" required>

  <select name="gender" required>
    <option value="">Select Gender</option>
    <option>Male</option>
    <option>Female</option>
    <option>Other</option>
  </select>

  <input type="text" name="aadhar_no" placeholder="Aadhar Number (12 digits)" pattern="[0-9]{12}" maxlength="12" required>
  <input type="text" name="pan_no" placeholder="PAN Card Number (e.g. ABCDE1234F)" pattern="[A-Z]{5}[0-9]{4}[A-Z]{1}" maxlength="10" required>

  <textarea name="address" placeholder="Enter Address" rows="3" required></textarea>

  <button type="submit">Add Customer</button>
</form>

<a href="home.jsp">🏠 Back to Home</a>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {
    String cid = request.getParameter("customer_id");
    String name = request.getParameter("name");
    String father = request.getParameter("father_name");
    String mother = request.getParameter("mother_name");
    int age = Integer.parseInt(request.getParameter("age"));
    String gender = request.getParameter("gender");
    String aadhar_no = request.getParameter("aadhar_no");
    String pan_no = request.getParameter("pan_no");
    String address = request.getParameter("address");

    if(age <= 18 || age > 118) {
        out.println("<p style='color:red;'>❌ Invalid Age! Must be above 18 and below 118.</p>");
    } else {
        try {
            PreparedStatement ps = conn.prepareStatement(
              "INSERT INTO customers (customer_id, name, father_name, mother_name, age, gender, aadhar_no, pan_no, address, balance) VALUES (?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, cid);
            ps.setString(2, name);
            ps.setString(3, father);
            ps.setString(4, mother);
            ps.setInt(5, age);
            ps.setString(6, gender);
            ps.setString(7, aadhar_no);
            ps.setString(8, pan_no);
            ps.setString(9, address);
            ps.setDouble(10, 0.0); // Default balance

            ps.executeUpdate();
            out.println("<p style='color:lightgreen;'>✅ Customer added successfully!</p>");
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: "+ e.getMessage() +"</p>");
        }
    }
}
%>

</body>
</html>
