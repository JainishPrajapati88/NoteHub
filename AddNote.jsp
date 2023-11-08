<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
try {
    String head = request.getParameter("head");
    String desc = request.getParameter("desc");

    Class.forName("com.mysql.jdbc.Driver");

    String jdbcURL = "jdbc:mysql://localhost:3306/Notes";
    String dbUser = "root";
    String dbPassword = ""; 
    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    String insertQuery = "INSERT INTO notes (Heading, Note) VALUES (?, ?)";
    PreparedStatement preparedStatement = conn.prepareStatement(insertQuery);
    preparedStatement.setString(1, head);
    preparedStatement.setString(2, desc);

    int rowsAffected = preparedStatement.executeUpdate();

    if (rowsAffected > 0) {
        response.sendRedirect("index.jsp");
    } else {
        out.println("Failed to insert data.");
    }
    conn.close();
} catch (Exception e) {
    out.println(e);
}
%>
