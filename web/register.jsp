<%@ page import="java.sql.*,javax.naming.*,javax.sql.*" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Context ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/studentdb");
    try (Connection conn = ds.getConnection();
         PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO register(name,email,password) VALUES (?,?,?)")) {

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.executeUpdate();
    }
    response.sendRedirect("thanks.html");

} catch (Exception e) {
    out.println("ERROR: " + e.getMessage());
}
%>
