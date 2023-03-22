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

/**
 *
 * @author willi
 */
public class MajorDBContext extends DBContext<Major> {

    @Override
    public void insert(Major model) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO Majors\n"
                    + "VALUES (?,?,?)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, model.getMajor_name());
            stm.setString(2, model.getMajor_code());
            stm.setString(3, model.getMajor_description());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void delete(Major model) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM Majors\n"
                    + "WHERE major_code = ?;";
            stm = connection.prepareStatement(sql);
            stm.setString(1, model.getMajor_code());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public ArrayList<Major> getAll() {
        ArrayList<Major> majors = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT major_id, major_name, major_code, major_description\n"
                    + "FROM Majors";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Major m = new Major();
                m.setMajor_id(rs.getInt("major_id"));
                m.setMajor_name(rs.getString("major_name"));
                m.setMajor_code(rs.getString("major_code"));
                m.setMajor_description(rs.getString("major_description"));
                majors.add(m);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return majors;
    }

    @Override
    public Major get(int id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT m.[major_id], m.[major_name], m.[major_code], m.[major_description]"
                    + "FROM Majors m "
                    + "WHERE m.major_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            Major m = new Major();
            if (rs.next()) {
                m.setMajor_id(rs.getInt("major_id"));
                m.setMajor_name(rs.getString("major_name"));
                m.setMajor_code(rs.getString("major_code"));
                m.setMajor_description(rs.getString("major_description"));
                return m;
            }
        } catch (SQLException ex) {
            Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public Major getByCode(String code) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT m.[major_id], m.[major_name], m.[major_code], m.[major_description]\n"
                    + "FROM Majors m \n"
                    + "WHERE m.major_code = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, code);
            rs = stm.executeQuery();
            Major m = new Major();
            if (rs.next()) {
                m.setMajor_id(rs.getInt("major_id"));
                m.setMajor_name(rs.getString("major_name"));
                m.setMajor_code(rs.getString("major_code"));
                m.setMajor_description(rs.getString("major_description"));
                return m;
            }
        } catch (SQLException ex) {
            Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public void updateMajorByCode(Major model, String code) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [Majors]\n"
                    + "SET [major_name] = ?,\n"
                    + "[major_code] =?,\n"
                    + "[major_description] = ?\n"
                    + "WHERE [major_code] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, model.getMajor_name());
            stm.setString(2, model.getMajor_code());
            stm.setString(3, model.getMajor_description());
            stm.setString(4, code);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MajorDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

//    public static void main(String[] args) {
//        MajorDBContext sdb = new MajorDBContext();
//        ArrayList<Major> s = sdb.getAll();
//        Major m = sdb.get("MC");
//        System.out.println(m.getMajor_name());
//
//    }

    @Override
    public void update(Major model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
