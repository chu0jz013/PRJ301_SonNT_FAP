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
public class GroupDBContext extends DBContext<Group> {

    @Override
    public void insert(Group model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Group model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Group model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Group get(int id) {
        int group_id = id;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select * \n"
                    + "from Groups g\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "where group_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, group_id);
            rs = stm.executeQuery();
            Group g = new Group();
            if (rs.next()) {
                Semester se = new Semester();
                se.setSemester_id(rs.getInt("semester_id"));
                se.setSemester_name(rs.getString("semester_name"));
                

                Course c = new Course();
                c.setCourse_id(rs.getInt("course_id"));
                c.setCourse_name(rs.getString("course_name"));

                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);
                g.setDay_of_week(rs.getString("days_of_week"));
                g.setCapacity(rs.getInt("capacity"));
                g.setSemester(se);

                return g;
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    @Override
    public ArrayList<Group> getAll() {
        ArrayList<Group> groups = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from groups";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                Course c = new Course();
                Semester se = new Semester();

                //set semeseter;
                se.setSemester_id(rs.getInt("semester_id"));
                se.setSemester_name(rs.getString("semester_name"));

                //set course
                c.setCourse_id(rs.getInt("course_id"));
                c.setCourse_code(rs.getString("course_code"));
                c.setCourse_name(rs.getString("course_name"));

                //set group
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);
                g.setDay_of_week(rs.getString("days_of_week"));
                g.setCapacity(rs.getInt("capacity"));
                g.setSemester(se);
                groups.add(g);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return groups;
    }

    public ArrayList<Group> getGroupByUserAndSemester(int user_id, int semester_id) {
        ArrayList<Group> groups = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select g.group_id, g.group_name,c.course_id, c.course_code,"
                    + " c.course_name, g.days_of_week, g.capacity, se.semester_name\n"
                    + "from Groups g\n"
                    + "join Enrollments e\n"
                    + "on e.group_id = g.group_id\n"
                    + "join Students s\n"
                    + "on s.student_id = e.student_id\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "where s.[user_id] = ? and se.semester_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            stm.setInt(2, semester_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                Course c = new Course();
                Semester se = new Semester();

                //set semeseter;
                se.setSemester_id(semester_id);
                se.setSemester_name(rs.getString("semester_name"));

                //set course
                c.setCourse_id(rs.getInt("course_id"));
                c.setCourse_code(rs.getString("course_code"));
                c.setCourse_name(rs.getString("course_name"));

                //set group
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);
                g.setDay_of_week(rs.getString("days_of_week"));
                g.setCapacity(rs.getInt("capacity"));
                g.setSemester(se);
                groups.add(g);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return groups;
    }

    public ArrayList<Group> getGroupBySemesterAndCourse(int semester_id, int course_id) {
        ArrayList<Group> groups = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select *\n"
                    + "from Groups g\n"
                    + "join Courses c\n"
                    + "on c.course_id = g.course_id\n"
                    + "join Semesters se\n"
                    + "on se.semester_id = g.semester_id\n"
                    + "where se.semester_id = ? and c.course_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, semester_id);
            stm.setInt(2, course_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                Course c = new Course();
                Semester se = new Semester();

                //set semeseter;
                se.setSemester_id(semester_id);
                se.setSemester_name(rs.getString("semester_name"));

                //set course
                c.setCourse_id(rs.getInt("course_id"));
                c.setCourse_code(rs.getString("course_code"));
                c.setCourse_name(rs.getString("course_name"));

                //set group
                g.setGroup_id(rs.getInt("group_id"));
                g.setGroup_name(rs.getString("group_name"));
                g.setCourse(c);
                g.setDay_of_week(rs.getString("days_of_week"));
                g.setCapacity(rs.getInt("capacity"));
                g.setSemester(se);
                groups.add(g);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return groups;
    }

}
