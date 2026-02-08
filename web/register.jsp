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

    String host = System.getenv("interchange.proxy.rlwy.net");
    String port = System.getenv("10798");
    String db   = System.getenv("railway");
    String user = System.getenv("root");
    String pass = System.getenv("UgKckuTTDEZMGSDmPHIkAOmKrMfUvzsA");

    if (host == null || port == null || db == null || user == null || pass == null) {
        out.println("Railway ENV variables missing");
        return;
    }

    String jdbcUrl =
        "jdbc:mysql://" + host + ":" + port + "/" + db +
        "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    conn = DriverManager.getConnection(jdbcUrl, user, pass);

    ps = conn.prepareStatement(
        "INSERT INTO register(name,email,password) VALUES (?,?,?)"
    );
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, password);

    ps.executeUpdate();
    response.sendRedirect("thanks.html");

} catch (Exception e) {
    out.println("DB ERROR: " + e);
} finally {
    try { if (ps != null) ps.close(); } catch(Exception ignored){}
    try { if (conn != null) conn.close(); } catch(Exception ignored){}
}
%>
