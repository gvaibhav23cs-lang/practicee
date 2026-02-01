<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Process</title>
</head>
<body>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // 🔥 JNDI DataSource lookup
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
        connection = ds.getConnection();

        String sql = "INSERT INTO contact (NAME, EMAIL, MESSAGE) VALUES (?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, email);
        preparedStatement.setString(3, message);

        int rows = preparedStatement.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("thanks.html");
        } else {
            out.println("Error: Failed to submit contact form");
        }

    } catch (Exception e) {
        out.println("Database Error: " + e.getMessage());
    } finally {
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>

</body>
</html>
