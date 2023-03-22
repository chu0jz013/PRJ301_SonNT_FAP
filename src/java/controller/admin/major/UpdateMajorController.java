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
public class UpdateMajorController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        String major_code = req.getParameter("major_code");
        req.getSession().setAttribute("major_code", major_code);
        MajorDBContext mdb = new MajorDBContext();
        Major m = mdb.getByCode(major_code);
        req.setAttribute("major", m);
        req.getRequestDispatcher("/view/admin/MajorManagement/update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        MajorDBContext mdb = new MajorDBContext();
        String raw_code = req.getParameter("major_code");
        String raw_name = req.getParameter("major_name");
        String raw_description = req.getParameter("major_description");
        Major m = new Major();
        m.setMajor_name(raw_name);
        m.setMajor_code(raw_code);
        m.setMajor_description(raw_description);
        String prev_code = (String) req.getSession().getAttribute("major_code");
        mdb.updateMajorByCode(m, prev_code);
        req.getSession().removeAttribute("major_code");
        resp.sendRedirect("/FPT_University_Management_System/admin/MajorManagement");

    }

}
