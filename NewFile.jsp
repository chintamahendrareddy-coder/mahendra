 <%@ page import = "java.sql.*"%>
<%@ page session = "true"%>
<%@ include file = "dbconnect.jsp"%>

<% 
	String msg = "";
	if(request.getParameter("login") != null)
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try(PreparedStatement ps = con.prepareStatement(
				"select * from admin where username = ? and password = ?")){
			ps.setString(1,username);
			ps.setString(2,password);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				session.setAttribute("adminUser",username);
				 
			}
			else
				msg = "Invalid username or password";
		}
		catch(Exception e)
		{
			msg = "Error: "+e.getMessage();
		}
	}
%>
<html>
	<head><title>login</title></head>
	<body>
		<div>
			<form method = "post">
				<input type = "text" name = "username" placeholder = "User Name" required/>
				<input type = "password" name = "password" placeholder = "Password" required/>
				<button type = "submit" name = "login">Login</button>
			</form>
			<% if(!msg.equals("")){ %>
			<p class = message><%=msg %></p>
			<%} %>
		</div>	
		<%if(con!=null)
			{
			try{
			con.close();
			}
			catch(Exception e)
			{}
			}%>
	</body>
</html>