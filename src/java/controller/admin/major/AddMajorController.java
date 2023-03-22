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
import java.util.ArrayList;
import model.Major;
import model.User;
import validation.Validation;

/**
 *
 * @author willi
 */
public class AddMajorController extends BaseRequiredAuthenticationController {

    Validation val = new Validation();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        MajorDBContext mdb = new MajorDBContext();
        String major_code = req.getParameter("major_code").toUpperCase();
        String major_name = val.capFirstLetter(req.getParameter("major_name"));
        String major_description = req.getParameter("major_description");
        if (!(major_code.isEmpty() || major_name.isEmpty())) {
            Major m = new Major();
            m.setMajor_name(major_name);
            m.setMajor_code(major_code);
            m.setMajor_description(major_description);
            mdb.insert(m);
        }
        resp.sendRedirect("/FPT_University_Management_System/admin/MajorManagement");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        req.getRequestDispatcher("/view/admin/MajorManagement/add.jsp").forward(req, resp);
    }

}
