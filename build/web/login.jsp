<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String email = request.getParameter("Email");
String password = request.getParameter("password");

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Context ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
    conn = ds.getConnection();

    String sql = "SELECT * FROM register WHERE email=? AND password=?";
    ps = conn.prepareStatement(sql);
    ps.setString(1, email);
    ps.setString(2, password);

    rs = ps.executeQuery();

    if (rs.next()) {
        response.sendRedirect("index.html");
    } else {
        out.println("<h3 style='color:red'>Invalid Email or Password</h3>");
    }

} catch (Exception e) {
    out.println("LOGIN ERROR: " + e.getMessage());
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>  
