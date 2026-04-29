<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>

<%
String id = request.getParameter("id");

try {
    Statement st = conn.createStatement();
    int result = st.executeUpdate("DELETE FROM customers WHERE customer_id='" + id + "'");
    
    if (result > 0) {
        // ✅ Redirect back to view page immediately
        response.sendRedirect("viewCustomers.jsp");
    } else {
        out.println("<script>alert('Customer not found!'); window.location='viewCustomers.jsp';</script>");
    }
} catch (Exception e) {
    out.println("<script>alert('Error deleting customer: " + e.getMessage() + "'); window.location='viewCustomers.jsp';</script>");
}
%>
