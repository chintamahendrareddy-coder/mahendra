<%@ page import="java.sql.*" %>
<%
Connection conn = null;
try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    // Read from environment variables (set these in Railway dashboard)
    String dbHost     = System.getenv("DB_HOST")     != null ? System.getenv("DB_HOST")     : "localhost";
    String dbPort     = System.getenv("DB_PORT")     != null ? System.getenv("DB_PORT")     : "1433";
    String dbName     = System.getenv("DB_NAME")     != null ? System.getenv("DB_NAME")     : "bankdb";
    String dbUser     = System.getenv("DB_USER")     != null ? System.getenv("DB_USER")     : "sa";
    String dbPassword = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "MyStrong@Pass123";

    String url = "jdbc:sqlserver://" + dbHost + ":" + dbPort
               + ";databaseName=" + dbName + ";encrypt=false";

    conn = DriverManager.getConnection(url, dbUser, dbPassword);
} catch (Exception e) {
    out.println("<p style='color:red;'>&#10060; Database connection failed: " + e.getMessage() + "</p>");
}
%>

