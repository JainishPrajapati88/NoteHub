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
    </style>
</head>
<body>
    <div class="note-container">
        <h1 class="note-heading">NoteTakingApp</h1>
        
        <div class="form-container">
            <%
                String GotHead = request.getParameter("headd");
                String head2Up = "";
                String desc2Up = "";
                try {
                    Class.forName("com.mysql.jdbc.Driver");

                    String jdbcURL = "jdbc:mysql://localhost:3306/Notes";
                    String dbUser = "root";
                    String dbPassword = "";
                    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    String sql = "SELECT * FROM notes WHERE Heading = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, GotHead);

                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        head2Up = rs.getString("Heading");
                        desc2Up = rs.getString("Note");
                    } else {
                        head2Up = rs.getString("Heading");
                        desc2Up = rs.getString("Note");
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            %>
            <form action="UpdatingNote.jsp" method="post">
                <div class="input-label">Heading</div>
                <input type="text" value="<%=head2Up%>" name="head" id="head" class="input-field">
                
                <div class="input-label">Description</div>
                <textarea name="desc" id="desc" rows="4" class="textarea-field"><%= desc2Up %></textarea>
                
                <div class="text-center">
                    <input type="hidden" value="<%=GotHead%>" name="headtoupdate">
                    <input type="submit" class="submit-button" value="Update Note">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
