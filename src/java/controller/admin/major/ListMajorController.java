/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.major;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.MajorDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Major;
import model.User;

/**
 *
 * @author willi
 */
public class ListMajorController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {

        MajorDBContext mdb = new MajorDBContext();
        ArrayList<Major> majors = mdb.getAll();
        req.setAttribute("majors", majors);
        req.getRequestDispatcher("/view/admin/MajorManagement/list.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        doGet(req, resp, user);
    }

}
