<%@ page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

if (name == null || email == null || password == null) {
    out.println("Form data missing");
    return;
}

Connection conn = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = System.getenv("MYSQL_URL");
    String user = System.getenv("MYSQL_USER");
    String pass = System.getenv("MYSQL_PASSWORD");

    conn = DriverManager.getConnection(url, user, pass);

    ps = conn.prepareStatement(
        "INSERT INTO register(name,email,password) VALUES (?,?,?)"
    );
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, password);

    ps.executeUpdate();
    response.sendRedirect("thanks.html");

} catch (Exception e) {
    out.println("ERROR: " + e);
} finally {
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>
