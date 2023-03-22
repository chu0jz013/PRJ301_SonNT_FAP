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
import model.Major;
import model.Student;

/**
 *
 * @author willi
 */
public class StudentDBContext extends DBContext<Student> {

    @Override
    public void insert(Student model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Student model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Student model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Student> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Student get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Student getStudentByUserId(int user_id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select s.student_id, s.student_code, s.first_name, s.last_name, s.email, s.phone, s.[address],\n"
                    + "s.student_imgsrc, m.[major_id], m.major_code, m.major_name\n"
                    + "from Students s\n"
                    + "join Majors m\n"
                    + "on s.major_id = m.major_id\n"
                    + "where s.[user_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            rs = stm.executeQuery();
            Student stu = new Student();
            if (rs.next()) {
                // set major
                Major m = new Major();
                m.setMajor_id(rs.getInt("major_id"));
                m.setMajor_code(rs.getString("major_code"));
                m.setMajor_name(rs.getString("major_name"));

                // set student
                stu.setStudent_id(rs.getInt("student_id"));
                stu.setStudent_code(rs.getString("student_code"));
                stu.setStudent_imgsrc(rs.getString("student_imgsrc"));
                stu.setFirst_name(rs.getString("first_name"));
                stu.setLast_name(rs.getString("last_name"));
                stu.setEmail(rs.getString("email"));
                stu.setPhone(rs.getString("phone"));
                stu.setAddress(rs.getString("address"));
                stu.setMajor(m);

                return stu;
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public ArrayList<Student> getStudentByGroup(int group_id) {
        ArrayList<Student> students = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select s.student_id, s.student_imgsrc, s.student_code, s.last_name, s.first_name\n"
                    + "from Groups g\n"
                    + "join Enrollments e\n"
                    + "on g.group_id = e.group_id\n"
                    + "join Students s\n"
                    + "on e.student_id = s.student_id\n"
                    + "where g.group_id = ?\n"
                    + "order by s.student_code";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, group_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Student stu = new Student();
                stu.setStudent_id(rs.getInt("student_id"));
                stu.setStudent_imgsrc(rs.getString("student_imgsrc"));
                stu.setStudent_code(rs.getString("student_code"));
                stu.setLast_name(rs.getString("last_name"));
                stu.setFirst_name(rs.getString("first_name"));
                students.add(stu);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        // sort
        //students.sort((s1, s2) -> s1.getStudent_code().compareTo(s2.getStudent_code()));
        return students;
    }

}
