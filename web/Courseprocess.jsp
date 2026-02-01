<%-- 
    Document   : Courseprocess
    Created on : Jan 28, 2025
    Author     : Vaibhav Gaikwad
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Process</title>
</head>
<body>

<%
String name = request.getParameter("name");
String studentId = request.getParameter("student_id");
String selectedcourse = request.getParameter("s_course");

Connection conn = null;
PreparedStatement ps = null;

try {
    Context ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
    conn = ds.getConnection();

    String sql = "INSERT INTO COURSE (name, student_id, s_course) VALUES (?, ?, ?)";
    ps = conn.prepareStatement(sql);
    ps.setString(1, name);
    ps.setString(2, studentId);
    ps.setString(3, selectedcourse);

    ps.executeUpdate();

    response.sendRedirect("view.jsp");

} catch (Exception e) {
    out.println("<h3 style='color:red'>DB Error: " + e.getMessage() + "</h3>");
} finally {
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>

</body>
</html>
