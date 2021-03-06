package dao;

import java.sql.*;


public class JDBC_List_Flags_Operations {
	
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
	
	public boolean isCheck_Task_Id(int taskId) {
		try {
			int count=0; 
			
			Connection conn = getConnection();
			
			String sql = "SELECT task_id FROM category_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()){
				count++;
    		}
			if(count==0) {
				rs.close();
				conn.close();
				return false;
			}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return true;
	}
	
	
	public void insertFlagRecord(int taskId, String[] categoryList) {
		try {
			Connection conn = getConnection();
			
			for(String i: categoryList) {
				String sql = "INSERT INTO category_table(task_id, category_list) VALUES(?,?);";
				PreparedStatement stmt = conn.prepareStatement(sql);
			
				stmt.setInt(1, taskId);
				stmt.setString(2,  i);
			
				stmt.executeUpdate();
			}
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	public void updateFlagRecord(int taskId, String[] categoryList) {
		try {
			
			deleteFlagRecord(taskId);
			
			Connection conn = getConnection();
			
			for(String i: categoryList) {
				String sql = "INSERT INTO category_table(task_id, category_list) VALUES(?,?);";
				PreparedStatement stmt = conn.prepareStatement(sql);
			
				stmt.setInt(1, taskId);
				stmt.setString(2,  i);
			
				stmt.executeUpdate();
			}
			conn.close();
			
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void deleteFlagRecord(int taskId) {
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
	
	
	public String getCategoryRecord(int taskId) {
		
		String category = "";
		
		try {
			
			Connection conn = getConnection();
			
			String sql = "SELECT category_list FROM category_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				category += rs.getString("category_list")+",";
			}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return category;
	}
}
