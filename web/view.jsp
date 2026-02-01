<%-- 
    Document   : view
    Created on : Jan 31, 2025, 5:22:50 PM
    Author     : vaibhav gaikwad
--%>

 
<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ page import="javax.servlet.http.*" %> 
<html> 
<head> 
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>Course Selected</title> 
    <style> 
        body { 
            font-family: 'Arial', sans-serif; 
            background-color: #f9f9f9; 
            margin: 0; 
            padding: 0; 
            color: #333; 
        } 
        .container { 
            max-width: 600px; 
            margin: 50px auto; 
            background-color: #fff; 
            padding: 20px; 
            border-radius: 8px; 
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); 
            text-align: center; 
        } 
        h2 { 
            color: #4CAF50; 
        } 
        a { 
            display: inline-block; 
            padding: 12px 24px; 
            background-color: #4CAF50; 
            color: #fff; 
            text-decoration: none; 
            border-radius: 8px; 
            transition: background-color 0.3s ease; 
            font-size: 18px; 
        } 
        a:hover { 
            background-color: #45a049; 
        } 
    </style> 
</head> 
<body> 
    <div class="container"> 
        <h2>Courses selected successfully</h2> 
        <a href="table.jsp">View Table</a> 
    </div> 
</body> 
</html> 
