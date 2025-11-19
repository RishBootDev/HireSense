package org.rishbootdev.hiresenseapplication.dbutils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static Connection conn;
	public static void openConnection(String dbUrl,String username,String password) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(dbUrl,username,password);
			System.out.println("Connected successfully to the database");
		}catch(SQLException ex) {
			System.out.println("Cannot open the connection in DBConnection");
			ex.printStackTrace();
		} catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
	public static Connection getConnection()throws SQLException{
		if(conn==null) {
			throw new SQLException("Connection not opened!");
		}
		return conn;
	}
	public static void closeConnection() {
		if(conn!=null) {
			try {
				conn.close();
				System.out.println("Connection closed successfully!");
			}catch(SQLException ex) {
				System.out.println("Cannot close the connection in DBConnection");
				ex.printStackTrace();
			}
		}
	}
}
