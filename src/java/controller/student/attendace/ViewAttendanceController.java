/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student.attendace;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.AttendanceDBContext;
import dal.EnrollmentDBContext;
import dal.GroupDBContext;
import dal.SemesterDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Attendance;
import model.Enrollment;
import model.Group;
import model.Semester;
import model.User;

/**
 *
 * @author willi
 */
public class ViewAttendanceController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {

        int user_id = Integer.parseInt(req.getParameter("user_id"));

        // get all semester
        int semester_id;
        Object ses_semester_id = req.getSession().getAttribute("semester_id");
        if (ses_semester_id != null) {
            semester_id = (int) ses_semester_id;
        } else {
            semester_id = 1;
        }
        SemesterDBContext sedb = new SemesterDBContext();
        ArrayList<Semester> ses = sedb.getAll();
        String raw_semester_id = req.getParameter("semester_id");
        if (raw_semester_id != null) {
            semester_id = Integer.parseInt(raw_semester_id);
        }
        req.getSession().setAttribute("semester_id", semester_id);

        // get all groups of that semester by user
        int group_id;
        Object ses_group_id = req.getSession().getAttribute("group_id");
        if (ses_group_id != null) {
            group_id = (int) ses_group_id;
        } else {
            group_id = 1;
        }
        GroupDBContext grdb = new GroupDBContext();
        ArrayList<Group> groups = grdb.getGroupByUserAndSemester(user_id, semester_id);
        String raw_group_id = req.getParameter("group_id");
        if (raw_group_id != null) {
            group_id = Integer.parseInt(raw_group_id);
        }
        req.getSession().setAttribute("group_id", group_id);

        AttendanceDBContext atdb = new AttendanceDBContext();
        ArrayList<Attendance> atts = atdb.getViewAttendance(user_id, group_id);
        req.setAttribute("viewAttendance", atts);

        EnrollmentDBContext endb = new EnrollmentDBContext();
        Enrollment en = endb.getEnrollmentByUserAndGroup(user_id, group_id);

        req.setAttribute("total_slot", en.getTotal_slot());
        req.setAttribute("total_absent_slot", en.getTotal_absent_slot());
        int absent_percentage = (int )Math.ceil(((float)en.getTotal_absent_slot()) / en.getTotal_slot() * 100);
        req.setAttribute("absent_percentage", absent_percentage);
        req.setAttribute("enrollment", en);
        req.setAttribute("groups", groups);
        req.setAttribute("semesters", ses);
        req.getRequestDispatcher("/view/student/viewattendance.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
    }

}
