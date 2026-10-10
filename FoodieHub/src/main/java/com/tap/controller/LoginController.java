
package com.tap.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.daoimpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String loginInput = req.getParameter("loginInput");
        String password = req.getParameter("password");

        UserDaoImpl userDao = new UserDaoImpl();

        User user =
                userDao.getUserByUsernameOrEmail(loginInput);

        boolean passwordMatches = false;

        if (user != null
                && password != null
                && user.getPassword() != null) {

            try {
                passwordMatches = BCrypt.checkpw(
                        password,
                        user.getPassword()
                );
            } catch (IllegalArgumentException e) {
                // Stored password is not a valid BCrypt hash.
                passwordMatches = false;
            }
        }

        if (user != null && passwordMatches) {

            HttpSession session = req.getSession();

            session.setAttribute("loggedInUser", user);

            resp.sendRedirect("checkout.jsp");

        } else {

            req.setAttribute(
                    "error",
                    "Invalid username/email or password"
            );

            req.getRequestDispatcher("login.jsp")
               .forward(req, resp);
        }
    }
}
