/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;
import model.Group;
import model.Semester;

/**
 *
 * @author willi
 */
public class CourseDBContext extends DBContext<Course> {

    @Override
    public void insert(Course model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Course model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Course model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Course get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Course> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Course> getBySemesterAndDepartment(int semester_id, int department_id) {
        ArrayList<Course> courses = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select c.course_id, c.course_code, c.course_name, g.group_id,\n"
                    + "g.group_name, g.days_of_week, g.capacity\n"
                    + "from Courses c\n"
                    + "join Groups g \n"
                    + "on g.course_id = c.course_id\n"
                    + "join Departments d\n"
                    + "on d.department_id = c.department_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "where se.semester_id = ? and d.department_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, semester_id);
            stm.setInt(2, department_id);
            rs = stm.executeQuery();
            while (rs.next()) {

                ArrayList<Group> groups = new ArrayList<>();

                Semester se = new Semester();
                se.setSemester_id(semester_id);

                Group g = new Group();
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setDay_of_week(rs.getString("days_of_week"));
                g.setCapacity(rs.getInt("capacity"));
                g.setSemester(se);

                Course c = new Course();
                c.setCourse_id(rs.getInt("course_id"));
                c.setCourse_name(rs.getString("course_name"));
                c.setCourse_code(rs.getString("course_code"));
                c.setGroups(groups);
                courses.add(c);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return courses;
    }

    public ArrayList<Course> getByDepartment(int department_id) {
        ArrayList<Course> courses = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select *\n"
                    + "from Courses\n"
                    + "where department_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, department_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setCourse_id(rs.getInt("course_id"));
                c.setCourse_name(rs.getString("course_name"));
                c.setCourse_code(rs.getString("course_code"));
                c.setCredit(rs.getFloat("credits"));
                c.setPreq_Course(rs.getString("prereq_course"));
                c.setDescription(rs.getString("description"));
                courses.add(c);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return courses;
    }

}
