<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NoteTakingApp</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .note-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .note-heading {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .input-label {
            font-size: 18px;
            margin-bottom: 8px;
            color: #333;
        }
        .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .textarea-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            resize: vertical;
        }
        .submit-button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 18px;
            cursor: pointer;
        }
        .note-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .note-table th, .note-table td {
            padding: 10px;
            text-align: left;
        }
        .note-table th {
            background-color: #007bff;
            color: #fff;
        }
        .note-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .note-actions {
            display: flex;
            gap: 10px;
        }
        .edit-button {
            background-color: #28a745;
        }
        .delete-button {
            background-color: #dc3545;
        }
        .note-actions button {
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="note-container">
        <h1 class="note-heading">NoteTakingApp</h1>
        
        <div class="form-container">
            <form action="AddNote.jsp" method="get">
                <div class="input-label">Heading</div>
                <input type="text" name="head" id="head" class="input-field">
                
                <div class="input-label">Description</div>
                <textarea name="desc" id="desc" rows="4" class="textarea-field"></textarea>
                
                <div class="text-center">
                    <input type="submit" class="submit-button" value="Add Note">
                </div>
            </form>
        </div>
        
        <h2 class="note-heading">Notes</h2>
        <table class="note-table">
            <thead>
                <tr>
                    <th>Heading</th>
                    <th>Note</th>
                    <th>DateTime</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    String jdbcURL = "jdbc:mysql://localhost:3306/Notes";
                    String dbUser = "root";
                    String dbPassword = ""; // Replace with your actual password
                    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    // Execute a query to retrieve notes from the database
                    String query = "SELECT Heading, Note, DateTime FROM notes ORDER BY DateTime DESC";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String heading = rs.getString("Heading");
                        String note = rs.getString("Note");
                        String dateTime = rs.getString("DateTime");
                %>
                <tr>
                    <td><%= heading %></td>
                    <td><%= note %></td>
                    <td><%= dateTime %></td>
                    <td class="note-actions">
                        <form action="UpdateNote.jsp" method="post">
                            <input type="hidden" name="headd" value="<%= heading %>">
                            <button class="edit-button">Edit</button>
                        </form>
                        <form action="DeletingNote.jsp" method="post">
                            <input type="hidden" name="headd" value="<%= heading %>">
                            <button class="delete-button">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                %>
            </tbody>
        </table>
    </div>
</body>
</html>