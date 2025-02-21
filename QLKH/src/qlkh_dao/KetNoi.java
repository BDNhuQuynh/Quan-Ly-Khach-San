/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package qlkh_dao;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author Admin
 */
public class KetNoi {
    private Connection connection;

    public void open() {
        try {
            String user = "sa";
            String pass = "123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=QLKS";
            connection = DriverManager.getConnection(url, user, pass);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public PreparedStatement prepareStatement(String sql) throws SQLException {
        if (connection == null || connection.isClosed()) {
            throw new SQLException("Connection is not established.");
        }
        return connection.prepareStatement(sql);
    }

    public void close(){
        try{
            this.connection.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }
    public ResultSet executeQuery(String sql){
        ResultSet rs = null;
        try{
            Statement st= connection.createStatement();
            rs= st.executeQuery(sql);
        }catch(Exception e){
           
        }
        return rs;
    }
    public int executeUpdate(String sql){
        int n= -1;
        try{
            Statement st = (Statement) connection.createStatement();
            n= st.executeUpdate(sql);
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return n;
    }
}

