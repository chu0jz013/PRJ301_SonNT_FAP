/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.professor.attendance;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.AttendanceDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import model.Attendance;
import model.User;

/**
 *
 * @author willi
 */
public class TakeAttendaceController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        AttendanceDBContext atdb = new AttendanceDBContext();
        Date date = Date.valueOf(req.getParameter("date"));
        int slot = Integer.parseInt(req.getParameter("slot"));
        int group_id = Integer.parseInt(req.getParameter("group_id"));

        req.setAttribute("group_id", group_id);
        ArrayList<Attendance> atts = atdb.getGroupAttendance(date, slot, group_id);
        req.getSession().setAttribute("attendances", atts);
        req.getRequestDispatcher("/view/professor/takeattendance.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {

        String[] student_ids = req.getParameterValues("student_ids");
        ArrayList<Attendance> atts = new ArrayList<>();
        for (String sid : student_ids) {
            Attendance a = new Attendance();
            a.setAttendance_id(Integer.parseInt(req.getParameter("attendance_id" + sid)));
            a.setStatus(req.getParameter("status" + sid));
            a.setNotes(req.getParameter("notes" + sid));
            atts.add(a);
        }
        AttendanceDBContext atdb = new AttendanceDBContext();
        atdb.updateAtts(atts);
        Date date = Date.valueOf(req.getParameter("date"));
        int slot = Integer.parseInt(req.getParameter("slot"));
        int group_id = Integer.parseInt(req.getParameter("group_id"));
        resp.sendRedirect("TakeAttendance?date=" + date + "&slot=" + slot + "&group_id=" + group_id);
    }
}
