<%-- 
    Document   : register
    Created on : Jan 30, 2025, 8:32:30?PM
    Author     : vaibhav gaikwad
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Context ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
    Connection conn = ds.getConnection();

    String sql = "INSERT INTO register(NAME, EMAIL, PASSWORD) VALUES (?,?,?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, password);

    ps.executeUpdate();

    ps.close();
    conn.close();

    response.sendRedirect("thanks.html");

} catch (Exception e) {
    out.println("ERROR: " + e.getMessage());
}
%>
