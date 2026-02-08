<%@ page import="java.sql.*,javax.naming.*,javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String email = request.getParameter("Email");
String newPassword = request.getParameter("newPassword");
String message = "";

if (email != null && newPassword != null) {
    try {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");

        try (Connection conn = ds.getConnection();
             PreparedStatement ps =
                 conn.prepareStatement(
                     "UPDATE register SET password=? WHERE email=?")) {

            ps.setString(1, newPassword);
            ps.setString(2, email);

            int updated = ps.executeUpdate();
            message = (updated > 0)
                    ? "Password updated successfully!"
                    : "Email not found!";
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - VAIBHAV UNIVERSITY</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
        }

        header {
            background-color: #333;
            padding: 15px 0;
            color: white;
        }

        nav {
            max-width: 1200px;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 24px;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            max-width: 600px;
            background: white;
            margin: 50px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .message {
            text-align: center;
            color: green;
            font-weight: bold;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>

<header>
    <nav>
        <a href="#" class="logo">VAIBHAV UNIVERSITY</a>
        <div class="nav-links">
            <a href="index.html">Home</a>
            <a href="about.html">About</a>
            <a href="contact.html">Contact</a>
            <a href="new.html">Login</a>
        </div>
    </nav>
</header>

<div class="container">
    <h2>Reset Password</h2>

    <% if (!message.isEmpty()) { %>
        <div class="message"><%= message %></div>
    <% } %>

    <form action="update.jsp" method="post">
        <label>Email</label>
        <input type="email" name="Email" required>

        <label>New Password</label>
        <input type="password" name="newPassword" required>

        <button type="submit">Update Password</button>
    </form>
</div>

</body>
</html>
