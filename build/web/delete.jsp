<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String studentId = request.getParameter("student_id");

Connection conn = null;
PreparedStatement ps = null;

if (studentId != null && !studentId.isEmpty()) {
    try {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
        conn = ds.getConnection();

        String sql = "DELETE FROM COURSE WHERE student_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, studentId);

        ps.executeUpdate();

        response.sendRedirect("table.jsp");

    } catch (Exception e) {
        out.println("<h3 style='color:red'>DELETE ERROR: " + e.getMessage() + "</h3>");
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
} else {
    out.println("<h3 style='color:red'>Invalid Student ID</h3>");
}
%>
