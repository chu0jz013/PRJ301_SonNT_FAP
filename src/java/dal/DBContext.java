/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sonnt
 */
public abstract class DBContext<T> {
    protected Connection connection;
    String instance = "";
    String serverName = "CHUOIZ-P1-XEO\\SQLEXPRESS";
    String portNumber = "1433";
    String dbName = "FPT_University_Management_System";
    String userID = "haikn";
    String password = "12345";
    
    public DBContext() {
        try {
            String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;
            if (instance == null || instance.trim().isEmpty()){
                url = "jdbc:sqlserver://" + serverName + ":" + portNumber +";databaseName=" + dbName;
        }
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, userID, password);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public abstract void insert(T model);

    public abstract void update(T model, int id);

    public abstract void delete(T model);
    
    public abstract T get(int id);

    public abstract ArrayList<T> getAll();
}
