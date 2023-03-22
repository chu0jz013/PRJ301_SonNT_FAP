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
import model.Feature;
import model.Role;
import model.Student;
import model.User;

/**
 *
 * @author sonnt
 */
public class UserDBContext extends DBContext<User> {

    public User get(String username, String password) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        String sql = "select * from Users\n"
                + "where [username] = ?\n"
                + "and [password] = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();

            if (rs.next()) {
                User s = new User();
                s.setUser_id(rs.getInt("user_id"));
                s.setUsername(rs.getString("username"));
                return s;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;

    }

    @Override
    public void insert(User model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(User model, int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(User model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<User> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public User get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public User getUserFull(String username, String password) {
        try {
            String sql = "SELECT u.[user_id], u.username\n"
                    + "	,r.role_id ,r.role_name\n"
                    + "	,f.feature_id,f.feature_name,f.[url]\n"
                    + "	FROM [Users] u \n"
                    + "	LEFT JOIN Role_User ru ON ru.[user_id] = u.[user_id]\n"
                    + "	LEFT JOIN [Roles] r ON r.role_id = ru.role_id\n"
                    + "	LEFT JOIN Role_Feature rf ON rf.role_id = r.role_id\n"
                    + "	LEFT JOIN Feature f ON rf.feature_id = f.feature_id\n"
                    + "WHERE u.username = ? AND u.[password] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            User user = null;
            Role currentRole = new Role();
            currentRole.setRole_id(-1);
            while (rs.next()) {
                if (user == null) {
                    user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    ArrayList<Role> roles = new ArrayList<>();
                    user.setRoles(roles);
                }

                int role_id = rs.getInt("role_id");
                if (role_id != 0) {
                    if (role_id != currentRole.getRole_id()) {
                        currentRole = new Role();
                        currentRole.setRole_id(rs.getInt("role_id"));
                        currentRole.setRole_name(rs.getString("role_name"));
                        ArrayList<Feature> features = new ArrayList<>();
                        currentRole.setFeatures(features);
                        user.getRoles().add(currentRole);
                    }
                }

                int feature_id = rs.getInt("feature_id");
                if (feature_id != 0) {
                    Feature f = new Feature();
                    f.setFeature_id(rs.getInt("feature_id"));
                    f.setFeature_name(rs.getString("feature_name"));
                    f.setUrl(rs.getString("url"));
                    currentRole.getFeatures().add(f);
                }
            }
            return user;
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

}
