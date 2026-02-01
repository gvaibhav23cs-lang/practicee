<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course Table</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background: #c0392b;
        }

        .btn-update {
            background: #3498db;
            color: white;
            margin-left: 5px;
        }

        .btn-update:hover {
            background: #2980b9;
        }

        .back-link {
            display: block;
            width: 200px;
            margin: 30px auto;
            text-align: center;
            background: #4CAF50;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-link:hover {
            background: #45a049;
        }
    </style>
</head>

<body>

<h2>Student Course Details</h2>

<table>
    <tr>
        <th>Name</th>
        <th>Student ID</th>
        <th>Course</th>
        <th>Action</th>
    </tr>

<%
Context ctx = new InitialContext();
DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
Connection conn = ds.getConnection();

Statement st = conn.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM COURSE");

while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("student_id") %></td>
        <td><%= rs.getString("s_course") %></td>
        <td>
            <!-- DELETE -->
            <form action="delete.jsp" method="post" style="display:inline;">
                <input type="hidden" name="student_id" value="<%= rs.getString("student_id") %>">
                <button type="submit" class="btn btn-delete"
                        onclick="return confirm('Are you sure you want to delete?')">
                    Delete
                </button>
            </form>

            <!-- UPDATE -->
            <form action="update.jsp" method="get" style="display:inline;">
                <input type="hidden" name="student_id" value="<%= rs.getString("student_id") %>">
                <button type="submit" class="btn btn-update">
                    Update
                </button>
            </form>
        </td>
    </tr>
<%
}

rs.close();
st.close();
conn.close();
%>

</table>

<a href="enroll.html" class="back-link">Back to Courses</a>

</body>
</html>
