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
import model.Enrollment;
import model.Group;
import model.Student;
import model.User;

/**
 *
 * @author willi
 */
public class EnrollmentDBContext extends DBContext<Enrollment> {

    @Override
    public void insert(Enrollment model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Enrollment model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Enrollment model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Enrollment> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ArrayList<Enrollment> getByStudentUserId(int user_id) {
        ArrayList<Enrollment> ens = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select * \n"
                    + "from Enrollments e\n"
                    + "join Students s\n"
                    + "on e.student_id = s.student_id\n"
                    + "where s.[user_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                // set student
                Student st = new Student();
                st.setStudent_id(rs.getInt("student_id"));
                st.setStudent_code(rs.getString("student_code"));

                // set enrollment
                Enrollment en = new Enrollment();
                en.setEnrollment_id(rs.getInt("enrollment_id"));
                en.setStudent(st);
                en.setTotal_slot(rs.getInt("total_slot"));
                en.setTotal_absent_slot(rs.getInt("total_absent_slot"));
                en.setComments(rs.getString("comments"));
                ens.add(en);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return ens;
    }

    public ArrayList<Enrollment> getByGroup(int group_id) {
        ArrayList<Enrollment> ens = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select * \n"
                    + "from Enrollments\n"
                    + "where group_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                // set student
                Student st = new Student();
                st.setStudent_id(rs.getInt("student_id"));

                // set enrollment
                Enrollment en = new Enrollment();
                en.setEnrollment_id(rs.getInt("enrollment_id"));
                en.setStudent(st);
                en.setTotal_slot(rs.getInt("total_slot"));
                en.setTotal_absent_slot(rs.getInt("total_absent_slot"));
                en.setComments(rs.getString("comments"));
                ens.add(en);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return ens;
    }

    public Enrollment getEnrollmentByUserAndGroup(int user_id, int group_id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select *\n"
                    + "from Enrollments e\n"
                    + "join Students s\n"
                    + "on e.student_id = s.student_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "where s.[user_id] = ? and g.group_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            stm.setInt(2, group_id);
            rs = stm.executeQuery();
            if (rs.next()) {

                // set group
                Group g = new Group();
                g.setGroup_id(rs.getInt("group_id"));

                // set user
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));

                // set student
                Student s = new Student();
                s.setUser(u);

                // set enrollment
                Enrollment en = new Enrollment();
                en.setEnrollment_id(rs.getInt("enrollment_id"));
                en.setTotal_absent_slot(rs.getInt("total_absent_slot"));
                en.setTotal_slot(rs.getInt("total_slot"));
                en.setGroup(g);
                en.setStudent(s);
                return en;
            }
        } catch (SQLException ex) {
            Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public ArrayList<Enrollment> getAllEnrollmentByGroup(int group_id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<Enrollment> ens = new ArrayList<>();
        try {
            String sql = "select e.enrollment_id, s.student_id, s.student_imgsrc ,s.student_code, \n"
                    + "s.first_name, s.last_name, e.total_slot, e.total_absent_slot, e.comments, u.[user_id]\n"
                    + "from Enrollments e\n"
                    + "join Students s\n"
                    + "on e.student_id = s.student_id\n"
                    + "join Groups g\n"
                    + "on g.group_id = e.group_id\n"
                    + "join Users u\n"
                    + "on u.[user_id] = s.[user_id]\n"
                    + "where g.group_id = ?\n"
                    + "order by s.student_code";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {

                //set user
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));

                //set student
                Student st = new Student();
                st.setStudent_id(rs.getInt("student_id"));
                st.setStudent_imgsrc(rs.getString("student_imgsrc"));
                st.setStudent_code(rs.getString("student_code"));
                st.setFirst_name(rs.getString("first_name"));
                st.setLast_name(rs.getString("last_name"));
                st.setUser(u);

                Enrollment en = new Enrollment();
                en.setTotal_slot(rs.getInt("total_slot"));
                en.setTotal_absent_slot(rs.getInt("total_absent_slot"));
                en.setEnrollment_id(rs.getInt("enrollment_id"));
                en.setComments(rs.getString("comments"));
                en.setStudent(st);

                ens.add(en);

            }
        } catch (SQLException ex) {
            Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EnrollmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return ens;
    }

    @Override
    public Enrollment get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
