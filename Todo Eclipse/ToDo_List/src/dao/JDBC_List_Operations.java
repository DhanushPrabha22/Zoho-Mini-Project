package dao;

import java.sql.*;


public class JDBC_List_Operations {
	
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
	
	
	public int getUserId(String email) {
		int id = -1;
		try{
			Connection conn = getConnection();
			String sql = "SELECT user_id FROM user_id_table WHERE email=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()){
    			id = rs.getInt("user_id");
    		}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		} 
		return id;
	}
	
	
	public int getTaskId(int userId, String taskName) {
		int id = -1;
		try{
			Connection conn = getConnection();
			String sql = "SELECT task_id FROM task_id_table WHERE user_id=? AND task_name=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, userId);
			stmt.setString(2, taskName);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()){
    			id = rs.getInt("task_id");
    		}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		} 
		return id;
	}
	
	
	public void insertTaskId(int userId, String taskName) {
		try{
			Connection conn = getConnection(); 
			String sql = "INSERT INTO task_id_table(user_id, task_name) VALUES(?,?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, userId);
			stmt.setString(2, taskName);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		} 
	}
	
	
	public void insertTaskDetails(int taskId, String description) {
		try{
			
			long millis = System.currentTimeMillis();  
			Date currDate = new java.sql.Date(millis); 
			
			Connection conn = getConnection(); 
			String sql = "INSERT INTO tasks_table(task_id, description, date_added, task_status) VALUES(?,?,?,?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, taskId);
			stmt.setString(2, description);
			stmt.setDate(3, currDate);
			stmt.setInt(4, 0);
			
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		} 
	}
	
	
	public boolean isCheckTaskName(int userId, String taskName) {
		try{
			int count=0; 
			
			Connection conn = getConnection();
			
			String sql = "SELECT task_name FROM task_id_table WHERE user_id=? AND task_name=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, userId);
			stmt.setString(2, taskName);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()){
				count++;
    		}
			if(count==0)
				return true;
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
}