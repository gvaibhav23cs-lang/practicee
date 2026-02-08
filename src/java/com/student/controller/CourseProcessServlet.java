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

@WebServlet("/courseprocess")
public class CourseProcessServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String studentId = request.getParameter("student_id");
        String course = request.getParameter("s_course");

        if (name == null || studentId == null || course == null) {
            response.getWriter().println("Form data missing");
            return;
        }

        try {
            // 🔹 JDBC DRIVER
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 🔹 Railway ENV VARS
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String db   = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            // 🔹 JDBC URL
            String jdbcUrl =
                "jdbc:mysql://" + host + ":" + port + "/" + db +
                "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            // 🔹 CONNECTION
            Connection conn = DriverManager.getConnection(jdbcUrl, user, pass);

            // 🔹 SQL
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO COURSE(name, student_id, s_course) VALUES (?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, studentId);
            ps.setString(3, course);

            ps.executeUpdate();

            ps.close();
            conn.close();

            response.sendRedirect("view.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB ERROR: " + e.getMessage());
        }
    }
}
