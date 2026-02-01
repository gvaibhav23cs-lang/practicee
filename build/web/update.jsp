<%-- 
    Document   : update
    Created on : Feb 5, 2025, 7:54:15?PM
    Author     : vaibhav gaikwad
--%>

<%@ page import="java.sql.*, java.io.*" %>
<%
   
    String email = request.getParameter("Email");
    String newPassword = request.getParameter("newPassword");
    String message = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    if (email != null && !email.isEmpty()) {
        try {
            
            String url = "jdbc:mysql://localhost:3306/StudentInformation"; 
            String dbUser = "root"; 
            String dbPassword = "Vaibhav@123"; 

         
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Query to check if the email exists
            String checkQuery = "SELECT * FROM register WHERE email = ?";
            ps = conn.prepareStatement(checkQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                
                if (newPassword != null && !newPassword.isEmpty()) {
                    
                    String updateQuery = "UPDATE register SET password = ? WHERE email = ?";
                    ps = conn.prepareStatement(updateQuery);
                    ps.setString(1, newPassword);
                    ps.setString(2, email);

                    int rowsUpdated = ps.executeUpdate();

                    if (rowsUpdated > 0) {
                        message = "Password updated successfully!";
                    } else {
                        message = "Error: Could not update password. Please try again.";
                    }
                }
            } else {
                message = "Email not found in the system!";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            message = "Error: Could not process request. Please try again later.";
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - VAIBHAV UNIVERSITY</title>
    <style>
        
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f2f2f2;
    color: #333;
}


header {
    background-color: #333;
    color: #fff;
    padding: 15px 0;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
}

header nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
}

header .logo {
    text-decoration: none;
    color: #fff;
    font-size: 24px;
    font-weight: bold;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

header .nav-links {
    display: flex;
    gap: 20px;
}

header .nav-links a {
    text-decoration: none;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    position: relative;
    transition: color 0.3s ease-in-out;
}

header .nav-links a:hover {
    color: #ff9900;
}

header .nav-links a::before {
    content: '';
    position: absolute;
    width: 100%;
    height: 2px;
    background-color: #ff9900;
    bottom: 5px;
    left: 0;
    transform: scaleX(0);
    transform-origin: 100% 50%;
    transition: transform 0.3s ease-in-out;
}

header .nav-links a:hover::before {
    transform: scaleX(1);
    transform-origin: 0 50%;
}

/* Main Content */
.container {
    max-width: 800px;
    margin: 40px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

.container h2 {
    text-align: center;
    color: #333;
    text-transform: uppercase;
    letter-spacing: 2px;
    margin-bottom: 20px;
}


.message {
    text-align: center;
    font-size: 18px;
    margin-bottom: 20px;
    color: #ff9900;
}


.update-form {
    margin-top: 20px;
}

form {
    display: flex;
    flex-direction: column;
    margin-top: 20px;
}

label {
    margin-bottom: 8px;
    color: #555;
    font-size: 16px;
}

input {
    margin-bottom: 16px;
    padding: 12px;
    border: 2px solid black;
    border-radius: 4px;
    background-color: #f9f9f9;
    color: #333;
    font-size: 16px;
}

/* Button Styles */
button {
    background-color: #4CAF50; 
    color: white;              
    font-size: 16px;           
    font-weight: bold;         
    padding: 12px 24px;       
    border: none;              
    border-radius: 4px;       
    cursor: pointer;          
    transition: background-color 0.3s ease, transform 0.2s ease; 
}

button:hover {
    background-color: #45a049; 
    transform: scale(1.05);     
}

button:focus {
    outline: none; 
}

button:active {
    transform: scale(1); 
}



footer {
    background-color: #4CAF50;
    color: #fff;
    text-align: center;
    padding: 20px 0;
    position: fixed;
    bottom: 0;
    width: 100%;
    font-size: 14px;
}

    </style>
</head>
<body>
    <header>
        <nav>
            <a href="logo.jpg" class="logo">VAIBHAV UNIVERSITY</a>
            <div class="nav-links">
                <a href="index.html">Home</a>
                <a href="about.html">About Us</a>
                <a href="contact.html">Contact</a>
                <a href="new.html">Login</a>
            </div>
        </nav>
    </header>

    <div class="container">
        <h2>Reset Password</h2>

        
        <div class="message">
            <h3><%= message %></h3>
        </div>

        
        <div class="update-form">
            <form action="update.jsp" method="post">
                <label for="Email">Enter your Registered Email:</label>
                <input type="email" id="Email" name="Email" required>

                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
                 <button onclick="window.location.href='login.html'">update Password</button>
            </form>
        </div>
    </div>
</body>
</html>


