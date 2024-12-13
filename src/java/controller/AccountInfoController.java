/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

/**
 *
 * @author An
 */

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AccountInfoController", urlPatterns = {"/user-info"})
public class AccountInfoController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.getRequestDispatcher("account_info.jsp").forward(request, response);
        } catch (Exception e) {
            log("Error at UserAccountController: " + e.toString());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load account information.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // You can add logic for handling form submissions (e.g., updating user information).
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method is not supported for this URL.");
    }
}

