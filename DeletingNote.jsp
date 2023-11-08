<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%

    try {
    String GotHead = request.getParameter("headd");

    Class.forName("com.mysql.jdbc.Driver");

    // Establish a database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/Notes";
    String dbUser = "root";
    String dbPassword = ""; // Replace with your actual password
    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // Create a SQL query using a prepared statement
    String deleteQuery = "DELETE FROM notes WHERE Heading = ?";
    PreparedStatement stmt = conn.prepareStatement(deleteQuery);
    stmt.setString(1, GotHead);
    int rowsAffected = stmt.executeUpdate();
    if (rowsAffected > 0) {
        out.println("<script>alert('Note Deleted')</script>");
        response.sendRedirect("index.jsp");
    } else {
        out.println("Failed to update data.");
    }

    conn.close();
} catch (Exception e) {
    out.println(e);
}
%>
