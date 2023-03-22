/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.group;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.CourseDBContext;
import dal.DepartmentDBContext;
import dal.GroupDBContext;
import dal.SemesterDBContext;
import dal.StudentDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Course;
import model.Group;
import model.Semester;
import model.Student;
import model.User;
import model.Department;

/**
 *
 * @author willi
 */
public class GroupsController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
//            int semester_id = 1;
//            SemesterDBContext sedb = new SemesterDBContext();
//            //list tat ca cac semester
//            ArrayList<Semester> ses = sedb.getAll();
//            req.setAttribute("semesters", ses);
//            String raw_semester_id = req.getParameter("semester_id");
//            if (raw_semester_id != null) {
//                semester_id = Integer.parseInt(req.getParameter("semester_id"));
//            }
//            // put to semeseter_id to session
//            req.getSession().setAttribute("semester_id", semester_id);
//
//            // get all department of that semester :
//            DepartmentDBContext dpmdb = new DepartmentDBContext();
//            ArrayList<Department> dpms = dpmdb.getAll();
//            req.setAttribute("dpms", dpms);
//            String raw_department_id = req.getParameter("department_id");
//            if (raw_department_id != null) {
//                int department_id = Integer.parseInt(req.getParameter("department_id"));
//                // put department_id to session
//                req.getSession().setAttribute("department_id", department_id);
//            }

//            // get all group
//            GroupDBContext grdb = new GroupDBContext();
//            ArrayList<Group> groups = grdb.getGroupByUserAndSemester(user.getUser_id(), semester_id);
//            req.setAttribute("groups", groups);
//            String raw_group_id = req.getParameter("group_id");
//            if (raw_group_id != null) {
//                int group_id = Integer.parseInt(raw_group_id);
//                req.setAttribute("group_id", group_id);
//                StudentDBContext stdb = new StudentDBContext();
//                ArrayList<Student> students = stdb.getStudentByGroup(group_id);
//                req.setAttribute("students", students);
//            }
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

        // get all department and send course
        int department_id;
        Object ses_department_id = req.getSession().getAttribute("department_id");
        if (ses_department_id != null) {
            department_id = (int) ses_department_id;
        } else {
            department_id = 1;
        }
        DepartmentDBContext dpmdb = new DepartmentDBContext();
        ArrayList<Department> dpms = dpmdb.getAll();
        String raw_department_id = req.getParameter("department_id");
        if (raw_department_id != null) {
            department_id = Integer.parseInt(raw_department_id);
        }
        req.getSession().setAttribute("department_id", department_id);

        // send courses
        ArrayList<Course> courses = new ArrayList<>();
        if (raw_department_id != null && raw_semester_id != null) {
            semester_id = (int) req.getSession().getAttribute("semester_id");
            department_id = (int) req.getSession().getAttribute("department_id");
        }
        CourseDBContext cdb = new CourseDBContext();
        courses = cdb.getByDepartment(department_id);

        int course_id;
        Object ses_course_id = req.getSession().getAttribute("course_id");
        if (ses_course_id != null) {
            course_id = (int) ses_course_id;
        } else {
            course_id = 1;
        }
        String raw_course_id = req.getParameter("course_id");
        if (raw_course_id != null) {
            course_id = Integer.parseInt(raw_course_id);
        }
        req.getSession().setAttribute("course_id", course_id);

        for (Course c : courses) {
            GroupDBContext grdb = new GroupDBContext();
            ArrayList<Group> groups = grdb.getGroupBySemesterAndCourse(semester_id, c.getCourse_id());
            c.setGroups(groups);
        }
        try {
            int group_id = Integer.parseInt(req.getParameter("group_id"));
            GroupDBContext grdb = new GroupDBContext();
            Group group = grdb.get(group_id);
            req.setAttribute("group", group);

            // get student of that group
            StudentDBContext stdb = new StudentDBContext();
            ArrayList<Student> students = stdb.getStudentByGroup(group_id);
            req.setAttribute("students", students);
        } catch (Exception e) {

        }

        req.setAttribute("courses", courses);
        req.setAttribute("departments", dpms);
        req.setAttribute("semesters", ses);

        req.getRequestDispatcher("/view/viewgroup.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
