package dao;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;


public class JDBC_List_Dates_Operations {

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
			
			String sql = "SELECT task_id FROM task_dates WHERE task_id=?;";
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
	
	
	public void insertDatesRecord(int taskId, Date dueDate, String repeat, Date remainderDate) {
		try {
			Connection conn = getConnection();
			
			String sql = "INSERT INTO task_dates(task_id, due_date, repeat_status, remainder_date) VALUES(?,?,?,?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, taskId);
			stmt.setDate(2, dueDate);
			stmt.setString(3, repeat);
			stmt.setDate(4, remainderDate);
			
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void updateDatesRecord(int taskId, Date dueDate, String repeat, Date remainderDate) {
		try {
			Connection conn = getConnection();
			
			String sql = "UPDATE task_dates SET due_date=?, repeat_status=?, remainder_date=? WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setDate(1, dueDate);
			stmt.setString(2, repeat);
			stmt.setDate(3, remainderDate);
			stmt.setInt(4, taskId);
			
			stmt.executeUpdate();
			conn.close();
			
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	public void deleteDatesRecord(int taskId) {
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
	
	
	public String[] getDatesRecord(int taskId) {
		
		String[] dates = new String[3];
		
		try {
			
			Date temp;
			String rep;
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			
			Connection conn = getConnection();
			
			String sql = "SELECT due_date, repeat_status, remainder_date FROM task_dates WHERE task_id=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, taskId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				try {
					temp = rs.getDate("due_date");
					dates[0] = dateFormat.format(temp);  
				}catch(Exception e){
					dates[0] = "";
				}
				
				try {
					rep = rs.getString("repeat_status");
					if(rep!=null)
						dates[1] = rep;
					else
						dates[1] = "";
				}catch(Exception e){
					dates[1] = "";
				}
				
				try {
					temp = rs.getDate("remainder_date");
					dates[2] = dateFormat.format(temp);  
				}catch(Exception e){
					dates[2] = "";
				}
			}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return dates;
	}
}
