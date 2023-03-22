/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.professor;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.DepartmentDBContext;
import dal.ProfessorDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Department;
import model.Professor;
import model.User;

/**
 *
 * @author willi
 */
public class ProfessorInfoController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        ProfessorDBContext prdb = new ProfessorDBContext();
        Professor pro = prdb.getByUser(user.getUser_id());

        DepartmentDBContext dpmdb = new DepartmentDBContext();
        ArrayList<Department> dpms = dpmdb.getDepByProfessor(pro.getProfessor_id());
        pro.setDepartments(dpms);

        req.setAttribute("professor", pro);
        req.getRequestDispatcher("/view/professor/info.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
