/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin.major;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.MajorDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Major;
import model.User;

/**
 *
 * @author willi
 */
public class DeleteMajorController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        MajorDBContext mdb = new MajorDBContext();
        Major m = new Major();
        m.setMajor_code(req.getParameter("major_code"));
        mdb.delete(m);
        resp.sendRedirect("/FPT_University_Management_System/admin/MajorManagement");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        doGet(req, resp, user);
    }

}
