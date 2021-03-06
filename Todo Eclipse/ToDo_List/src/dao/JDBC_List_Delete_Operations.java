package dao;

import java.sql.*;


public class JDBC_List_Delete_Operations {
	
	public Connection getConnection() {
		try{
			//Database Connection
			Class.forName("com.mysql.jdbc.Driver");  
			Connection conn = DriverManager.getConnection(JDBCUtils.getUrl(), JDBCUtils.getUsername(), JDBCUtils.getPassword());
			return conn;
		}catch(Exception e){
			System.out.println(e);
		} 
		return null;
	}
	
	
	public void deleteSubTaskRecord(int taskId) {
		try {
			Connection conn = getConnection();
			
			String sql = "DELETE FROM subtasks_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void deleteDateRecord(int taskId) {
		try {
			Connection conn = getConnection();
			
			String sql = "DELETE FROM task_dates WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}

	
	public void deleteCategoryRecord(int taskId) {
		try {
			Connection conn = getConnection();
			
			String sql = "DELETE FROM category_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void deleteTaskRecord(int taskId) {
		try {
			Connection conn = getConnection();
			
			String sql = "DELETE FROM tasks_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void deleteTaskIdRecord(int taskId) {
		try {
			Connection conn = getConnection();
			
			String sql = "DELETE FROM task_id_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
}
