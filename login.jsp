<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Check</title>
<style>
body {
    background-image: url('https://media.istockphoto.com/id/1432744240/vector/concept-of-banking-and-finance.jpg?s=612x612&w=0&k=20&c=5YCtZpM5o1_MUnYqKvvCYA4ceby3JcU6faq7nUafhRI=');
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    font-family: 'Poppins', sans-serif;
    color: white;
}
.message {
    text-align: center;
    margin-top: 200px;
    font-size: 20px;
}
a {
    color: #fff;
    text-decoration: none;
    background: rgba(0, 0, 0, 0.5);
    padding: 8px 15px;
    border-radius: 8px;
}
a:hover {
    background: rgba(0, 0, 0, 0.8);
}
</style>
</head>
<body>
<%
String user = request.getParameter("username");
String pass = request.getParameter("password");

if("admin".equals(user) && "admin123".equals(pass)) {
    session.setAttribute("admin", user);
    response.sendRedirect("home.jsp");
} else {
%>
<div class="message">
    <p style="color:yellow;">❌ Invalid login! Try again.</p>
    <p><a href="index.jsp">🔙 Back to Login</a></p>
</div>
<%
}
%>
</body>
</html>
