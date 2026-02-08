/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ===== FORM DATA =====
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (name == null || email == null || password == null) {
            response.getWriter().println("Form data missing");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // ===== LOAD DRIVER =====
            Class.forName("com.mysql.cj.jdbc.Driver");

            // ===== READ ENV VARS (RAILWAY) =====
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String db   = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            // ===== FALLBACK FOR LOCALHOST =====
            if (host == null || port == null || db == null || user == null || pass == null) {
                host = "interchange.proxy.rlwy.net";
                port = "10798";
                db   = "railway";     // 🔁 change if your local DB name is different
                user = "root";
                pass = "UgKckuTTDEZMGSDmPHIkAOmKrMfUvzsA";          // 🔁 change your local MySQL password
            }

            // ===== JDBC URL =====
            String jdbcUrl =
                "jdbc:mysql://" + host + ":" + port + "/" + db +
                "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            // ===== CONNECT =====
            conn = DriverManager.getConnection(jdbcUrl, user, pass);

            // ===== INSERT QUERY =====
            ps = conn.prepareStatement(
                "INSERT INTO register(name,email,password) VALUES (?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            ps.executeUpdate();

            // ===== SUCCESS =====
            response.sendRedirect("thanks.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB ERROR: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    // Optional test
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("RegisterServlet is running OK");
    }
}

