<%@ page import="java.sql.*" %>
<%
Connection conn = null;
try {
    Class.forName("org.postgresql.Driver");
    String host     = System.getenv("PGHOST");
    String port     = System.getenv("PGPORT");
    String database = System.getenv("PGDATABASE");
    String user     = System.getenv("PGUSER");
    String password = System.getenv("PGPASSWORD");
    String url = "jdbc:postgresql://" + host + ":" + port + "/" + database + "?sslmode=require";
    conn = DriverManager.getConnection(url, user, password);
} catch (Exception e) {
    out.println("<p style='color:red;'>DB Error: " + e.getMessage() + "</p>");
}
%>
