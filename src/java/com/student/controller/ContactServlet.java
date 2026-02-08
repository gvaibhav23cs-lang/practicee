package com.student.controller;



import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (name == null || email == null || message == null) {
            response.getWriter().println("Form data missing");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // ===== Railway ENV =====
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String db   = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            // ===== Local fallback =====
            if (host == null) {
                host = "interchange.proxy.rlwy.net";
                port = "10798";
                db   = "railway";
                user = "root";
                pass = "UgKckuTTDEZMGSDmPHIkAOmKrMfUvzsA";     // 🔁 local password
            }

            String jdbcUrl =
                "jdbc:mysql://" + host + ":" + port + "/" + db +
                "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            conn = DriverManager.getConnection(jdbcUrl, user, pass);

            ps = conn.prepareStatement(
                "INSERT INTO contact(name,email,message) VALUES (?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, message);

            ps.executeUpdate();

            response.sendRedirect("thanks.html");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB ERROR: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    // quick test
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.getWriter().println("ContactServlet working");
    }
}
