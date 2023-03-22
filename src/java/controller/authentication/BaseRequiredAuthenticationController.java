/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authentication;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Feature;
import model.Role;
import model.User;
import validation.Validation;

/**
 *
 * @author sonnt
 */
public abstract class BaseRequiredAuthenticationController extends HttpServlet {

    public Validation val = new Validation();

//    private boolean isAuthenticated(HttpServletRequest request) {
//        User user = (User) request.getSession().getAttribute("user");
//        return user != null;
//    }
    private boolean isAuthorized(HttpServletRequest req) {
        User user = (User) req.getSession().getAttribute("user");
        String currentUrl = req.getServletPath();//"/student/add"
        try {
            for (Role role : user.getRoles()) {
                //System.out.println(role.getRole_name());
                for (Feature feature : role.getFeatures()) {
                    //System.out.println(feature.getFeature_name());
                    if (feature.getUrl().equals(currentUrl)) {
                        //System.out.println(feature.getUrl());
                        return true;
                    }
                }
            }
        } catch (Exception e) {

        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isAuthorized(req)) {
            //do business
            doPost(req, resp, (User) req.getSession().getAttribute("user"));
        } else {
            resp.sendRedirect("/FPT_University_Management_System/login");
        }
    }

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException;

    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isAuthorized(req)) {
            //do business
            doGet(req, resp, (User) req.getSession().getAttribute("user"));
        } else {
            resp.getWriter().print("hehe");
            req.getRequestDispatcher("/authentication/login_fail.jsp").forward(req, resp);
        }
    }

}
