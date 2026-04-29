<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="dbconnect.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Smart Loan & Payment Page</title>
<style>
body {
  font-family: 'Poppins', sans-serif;
  background: linear-gradient(135deg, #e8f5e9, #f3f9f8);
  text-align: center;
  margin: 0;
}
h2 { 
  background: #4CAF50; 
  color: white; 
  padding: 15px; 
}
form {
  background: white;
  width: 420px;
  margin: 30px auto;
  padding: 25px;
  border-radius: 15px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
input, select {
  width: 90%;
  padding: 10px;
  margin: 10px 0;
  border-radius: 8px;
  border: 1px solid #ccc;
}
button {
  background: #43a047;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  cursor: pointer;
  transition: 0.3s;
}
button:hover { background: #2e7d32; transform: scale(1.05); }
a { text-decoration:none; color:#43a047; display:block; margin-top:20px; }
</style>
</head>
<body>

<h2>🏦 Smart Loan and Payment System</h2>

<!-- Step 1: Enter Customer ID -->
<form method="post">
  <input type="text" name="customer_id" placeholder="Enter Customer ID" required>
  <button type="submit" name="check_customer">Continue</button>
</form>

<%
if(request.getParameter("check_customer") != null){
    String cid = request.getParameter("customer_id");
    try {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM customers WHERE customer_id=?");
        ps.setString(1, cid);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            double loan = rs.getDouble("loan_amount");
            double paid = rs.getDouble("loan_paid");
            String status = rs.getString("loan_status");

            if(loan > 0 && !"PAID".equalsIgnoreCase(status)){
                // Existing loan - show payment section
                out.println("<div style='background:white;width:420px;margin:20px auto;padding:20px;border-radius:10px;'>");
                out.println("<h3>💰 Existing Loan Details</h3>");
                out.println("<p><b>Name:</b> "+rs.getString("name")+"</p>");
                out.println("<p><b>Loan Amount:</b> ₹"+String.format("%.2f", loan)+"</p>");
                out.println("<p><b>Already Paid:</b> ₹"+String.format("%.2f", paid)+"</p>");
                out.println("<p><b>Loan Taken Date:</b> "+rs.getString("loan_date")+"</p>");
                out.println("<form method='post'>");
                out.println("<input type='hidden' name='cid' value='"+cid+"'>");
                out.println("<p><b>Enter Payment Date:</b></p>");
                out.println("<input type='date' name='pay_date' required>");
                out.println("<button type='submit' name='show_interest'>Show Interest & Amount</button>");
                out.println("</form>");
                out.println("</div>");
            } else {
                // No active loan - ask for CIBIL
                out.println("<form method='post'>");
                out.println("<input type='hidden' name='cid' value='"+cid+"'>");
                out.println("<input type='number' name='civil_score' placeholder='Enter CIBIL Score' required min='300' max='950'>");
                out.println("<button type='submit' name='check_cibil'>Check Eligibility</button>");
                out.println("</form>");
            }
        } else {
            out.println("<p style='color:red;'>⚠️ No customer found with ID: "+cid+"</p>");
        }
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    }
}
%>

<!-- Step 2: CIBIL-based loan eligibility -->
<%
if(request.getParameter("check_cibil") != null){
    String cid = request.getParameter("cid");
    int civil = Integer.parseInt(request.getParameter("civil_score"));
    int loanAmt = 0;

    if(civil >= 700 && civil < 800) loanAmt = 10000;
    else if(civil >= 800 && civil <= 900) loanAmt = 20000;
    else if(civil > 900) loanAmt = 30000;

    if(loanAmt == 0){
        out.println("<p style='color:red;'>❌ CIBIL too low for loan approval.</p>");
    } else {
        out.println("<p style='color:green;'>✅ Eligible for ₹"+loanAmt+" loan.</p>");
        out.println("<form method='post'>");
        out.println("<input type='hidden' name='cid' value='"+cid+"'>");
        out.println("<input type='hidden' name='max_loan' value='"+loanAmt+"'>");
        out.println("<p><b>Enter Loan Amount (max ₹"+loanAmt+"):</b></p>");
        out.println("<input type='number' name='loan_taken' min='1000' max='"+loanAmt+"' required>");
        out.println("<p><b>Loan Taken Date:</b></p>");
        out.println("<input type='date' name='loan_date' required>");
        out.println("<button type='submit' name='take_loan'>Take Loan</button>");
        out.println("</form>");
    }
}
%>

<!-- Step 3: Take loan and add to balance -->
<%
if(request.getParameter("take_loan") != null){
    String cid = request.getParameter("cid");
    double loanTaken = Double.parseDouble(request.getParameter("loan_taken"));
    String loanDate = request.getParameter("loan_date");

    try {
        PreparedStatement ps = conn.prepareStatement(
          "UPDATE customers SET loan_amount=?, loan_paid=0, loan_status='APPROVED', loan_date=?, balance=balance+? WHERE customer_id=?");
        ps.setDouble(1, loanTaken);
        ps.setString(2, loanDate);
        ps.setDouble(3, loanTaken); // ✅ Add loan amount to balance
        ps.setString(4, cid);
        ps.executeUpdate();

        out.println("<p style='color:green;'>✅ Loan Approved & Added to Balance Successfully!</p>");
        out.println("<p><b>Loan Amount:</b> ₹"+String.format("%.2f", loanTaken)+"</p>");
        out.println("<p><b>Loan Date:</b> "+loanDate+"</p>");
        out.println("<p style='color:gray;'>💡 Interest will be calculated when you pay.</p>");
    } catch(Exception e){
        out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    }
}
%>

<!-- Step 4: Show interest and total payable before payment -->
<%
if(request.getParameter("show_interest") != null){
    String cid = request.getParameter("cid");
    String payDate = request.getParameter("pay_date");

    try {
        PreparedStatement ps = conn.prepareStatement("SELECT loan_amount, loan_date FROM customers WHERE customer_id=?");
        ps.setString(1, cid);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            double loanAmt = rs.getDouble("loan_amount");
            java.time.LocalDate ldate = java.time.LocalDate.parse(rs.getString("loan_date"));
            java.time.LocalDate pdate = java.time.LocalDate.parse(payDate);

            long days = java.time.temporal.ChronoUnit.DAYS.between(ldate, pdate);
            if(days < 1) days = 1;

            double interest = (loanAmt * 0.10 * days) / 365;
            double totalDue = loanAmt + interest;

            out.println("<div style='background:white;width:420px;margin:20px auto;padding:20px;border-radius:10px;'>");
            out.println("<h3>📅 Payment Calculation</h3>");
            out.println("<p><b>Loan Date:</b> "+ldate+"</p>");
            out.println("<p><b>Payment Date:</b> "+pdate+"</p>");
            out.println("<p><b>Interest (10% p.a for "+days+" days):</b> ₹"+String.format("%.2f", interest)+"</p>");
            out.println("<p><b>Total Amount to Pay:</b> ₹"+String.format("%.2f", totalDue)+"</p>");
            out.println("<form method='post'>");
            out.println("<input type='hidden' name='cid' value='"+cid+"'>");
            out.println("<input type='hidden' name='pay_date' value='"+payDate+"'>");
            out.println("<input type='hidden' name='total_due' value='"+totalDue+"'>");
            out.println("<button type='submit' name='confirm_pay'>Confirm & Pay</button>");
            out.println("</form>");
            out.println("</div>");
        }
    } catch(Exception e){
        out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    }
}
%>

<!-- Step 5: Confirm and pay -->
<%
if(request.getParameter("confirm_pay") != null){
    String cid = request.getParameter("cid");
    String payDate = request.getParameter("pay_date");
    double totalDue = Double.parseDouble(request.getParameter("total_due"));

    try {
        PreparedStatement up = conn.prepareStatement(
            "UPDATE customers SET loan_paid=?, pay_date=?, loan_status='PAID', balance=balance-? WHERE customer_id=?");
        up.setDouble(1, totalDue);
        up.setString(2, payDate);
        up.setDouble(3, totalDue); // ✅ Deduct payment from balance
        up.setString(4, cid);
        up.executeUpdate();

        out.println("<div style='background:white;width:420px;margin:20px auto;padding:20px;border-radius:10px;'>");
        out.println("<h3>✅ Payment Successful!</h3>");
        out.println("<p><b>Total Paid:</b> ₹"+String.format("%.2f", totalDue)+"</p>");
        out.println("<p><b>Payment Date:</b> "+payDate+"</p>");
        out.println("<p style='color:blue;'>🎉 Loan Fully Repaid and Balance Updated!</p>");
        out.println("</div>");
    } catch(Exception e){
        out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    }
}
%>

<a href="home.jsp">🏠 Back to Home</a>

</body>
</html>
