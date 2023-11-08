<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    out.println(request.getParameter("headtoupdate"));
try {
    String head = request.getParameter("head");
    String desc = request.getParameter("desc");
    String GotHead = request.getParameter("headtoupdate");

    Class.forName("com.mysql.jdbc.Driver");

    // Establish a database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/Notes";
    String dbUser = "root";
    String dbPassword = ""; // Replace with your actual password
    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // Create a SQL query using a prepared statement
    String updateQuery = "UPDATE notes SET heading = ?, Note = ? WHERE Heading = ?";
    PreparedStatement stmt = conn.prepareStatement(updateQuery);
    stmt.setString(1, head);
    stmt.setString(2, desc);
    stmt.setString(3, GotHead);
    int rowsAffected = stmt.executeUpdate();
    if (rowsAffected > 0) {
        out.println("<script>alert('Note Updated')</script>");
        response.sendRedirect("index.jsp");
    } else {
        out.println("Failed to update data.");
    }

    conn.close();
} catch (Exception e) {
    out.println(e);
}
%>
