package dao;

import java.sql.*;


public class JDBC_List_SubTasks_Operations {
	
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
			
			String sql = "SELECT task_id FROM subtasks_table WHERE task_id=?;";
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
	
	
	public void insertSubTaskRecord(int taskId, String[] subTasks) {
		try {
			Connection conn = getConnection();
			
			for(String i:subTasks) {
				String sql = "INSERT INTO subtasks_table(task_id, subtask_list) VALUES(?,?);";
				PreparedStatement stmt = conn.prepareStatement(sql);
			
				stmt.setInt(1, taskId);
				stmt.setString(2, i);
			
				stmt.executeUpdate();
			}
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void updateSubTaskRecord(int taskId, String[] subTasks) {
		try {
			
			deleteSubTaskRecord(taskId);
			
			Connection conn = getConnection();
			
			for(String i:subTasks) {
				String sql = "INSERT INTO subtasks_table(task_id, subtask_list) VALUES(?,?);";
				PreparedStatement stmt = conn.prepareStatement(sql);
			
				stmt.setInt(1, taskId);
				stmt.setString(2, i);
			
				stmt.executeUpdate();
			}
			conn.close();
			
		}catch(Exception e){
			System.out.println(e);
		}
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
	
	
	public String getSubTaskRecord(int taskId) {
		
		String subTasks="";
		
		try {
			
			Connection conn = getConnection();
			
			String sql = "SELECT subtask_list FROM subtasks_table WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				subTasks += rs.getString("subtask_list")+",";
			}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return subTasks;
	}
}
