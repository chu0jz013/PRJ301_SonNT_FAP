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
import model.Professor;

/**
 *
 * @author willi
 */
public class ProfessorDBContext extends DBContext<Professor> {

    @Override
    public void insert(Professor model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Professor model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Professor model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Professor get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Professor> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Professor getByUser(int user_id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "select * \n"
                    + "from Professors p\n"
                    + "where p.[user_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            rs = stm.executeQuery();
            Professor pro = new Professor();
            if (rs.next()) {
                // set professor
                pro.setProfessor_id(rs.getInt("professor_id"));
                pro.setProfessor_imgsrc(rs.getString("professor_imgsrc"));
                pro.setProfessor_code(rs.getString("professor_code"));
                pro.setFirst_name(rs.getString("first_name"));
                pro.setLast_name(rs.getString("last_name"));
                pro.setEmail(rs.getString("email"));
                pro.setPhone(rs.getString("phone"));
                pro.setAddress(rs.getString("address"));
                return pro;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProfessorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProfessorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

}
