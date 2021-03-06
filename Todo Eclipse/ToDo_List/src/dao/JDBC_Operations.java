package dao;

import java.sql.*;
import java.time.Period;
import java.util.regex.Pattern;


public class JDBC_Operations {

	
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
	
	
	public boolean insertUser(String email, String pwd, String secAns){
		try{
			TrippleDES tripledes = new TrippleDES();
			
			String encrypted1 = tripledes.encrypt(pwd);
			
			String normalSecAns = noamalizeSecurityAnswer(secAns);
			String encrypted2 = tripledes.encrypt(normalSecAns);
			
			Connection conn = getConnection();
			String sql = "INSERT INTO logindetails(email,password,security) VALUES(?,?,?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, encrypted1);
			stmt.setString(3, encrypted2);
			stmt.executeUpdate();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
	
	public boolean insertAccount(String email) {
		try{
			Connection conn = getConnection();
			   
			String sql = "INSERT INTO accountdetails(email) VALUES(?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.executeUpdate();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
	
	public boolean createUserID(String email) {
		try{
			Connection conn = getConnection();
			   
			String sql = "INSERT INTO user_id_table(email) VALUES(?);";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.executeUpdate();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
		
	public boolean updatePassword(String email, String new_pwd) {
		try{
			TrippleDES tripledes = new TrippleDES();
			
			String encrypted = tripledes.encrypt(new_pwd);
			
			Connection conn = getConnection();
			String sql = "UPDATE logindetails SET password=? WHERE email='"+email+"';";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, encrypted);
			stmt.executeUpdate();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
	
	public boolean isValid_Email(String email) {
		
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+ 
                			"[a-zA-Z0-9_+&*-]+)*@" + 
                			"(?:[a-zA-Z0-9-]+\\.)+[a-z" + 
                			"A-Z]{2,7}$"; 
		Pattern pat = Pattern.compile(emailRegex); 
		if (email == null) 
            return false; 
        return pat.matcher(email).matches(); 
	}
	
	
	public boolean isCheck_Email(String email){
		try{
			Connection conn = getConnection();
			String sql = "SELECT * FROM logindetails WHERE email='"+email+"';";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			int count = 0;
			while (rs.next()) 
    			count++;
    		if(count==0) {
    			rs.close();
    			conn.close();
    			return false;
    		}
    		rs.close();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
	
	public boolean isCheck_SecurityAnswer(String email, String secAns){
		try{
			Connection conn = getConnection();
			String sql = "SELECT * FROM logindetails WHERE email='"+email+"';";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			int count = 0;
			String encryptedText = "";
			while (rs.next()){
    			count++;
    			encryptedText += rs.getString("security");
    		}
    		if(count==0) {
    			rs.close();
    			conn.close();
    			return false;
    		}
    		TrippleDES tripledes = new TrippleDES();
    		
    		String decrypted = tripledes.decrypt(encryptedText);
    		
    		String normalSecAns = noamalizeSecurityAnswer(secAns);
    		
    		if(!decrypted.equalsIgnoreCase(normalSecAns)) {
    			rs.close();
    			conn.close();
    			return false;
    		}
    		rs.close();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
	
	public boolean isCheck_Password(String email, String password) {
		try {
			Connection conn = getConnection();
			
			String sql = "SELECT * FROM logindetails WHERE email='"+email+"';";
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			int count = 0;
			String encryptedText = "";
			while (rs.next()){
    			count++;
    			encryptedText += rs.getString("password");
    		}
    		if(count==0) {
    			rs.close();
    			conn.close();
    			return false;
    		}
    		TrippleDES tripledes = new TrippleDES();
    		
    		String decrypted = tripledes.decrypt(encryptedText);
    		if(!decrypted.equals(password)) {
    			rs.close();
    			conn.close();
    			return false;
    		}
    		rs.close();
			conn.close();
			return true;
		}catch(Exception e){
			System.out.println(e);
		} 
		return false;
	}
	
	
	public boolean isCheckStatus(String email, String password) {
		try {
			long millis = System.currentTimeMillis();  
			Date currDate = new java.sql.Date(millis);  
			Date lockedDate;
			int years=0, months=0, days=0;
			
			Connection conn = getConnection();
			
			String sql = "SELECT account_status, locked_date FROM accountdetails WHERE email='"+email+"';";
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			if(rs.getInt("account_status")==1) {
				rs.close();
				conn.close();
				return true;
			}else {
				lockedDate = rs.getDate("locked_date");
				if(lockedDate!=null && isCheck_Password(email, password)) {
					Period age = Period.between(lockedDate.toLocalDate(), currDate.toLocalDate());
					years = age.getYears(); 
					months = age.getMonths();
					days = age.getDays();
					if(years>0 || months>0 || days>2) {
						unlockAccount(email);
						rs.close();
						conn.close();
						return true;
					}
				}
			}
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
		return false;
	}
	
	
	public void updateBadLogins(String email) {
		try {
			Connection conn = getConnection();
		
			String sql = "SELECT bad_logins, account_status FROM accountdetails WHERE email='"+email+"';";
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			int badLogins = rs.getInt("bad_logins");
			
			
			if((badLogins+1)>2) {
				lockAccount(email);
				resetBadLogins(email);
			}else {
				increaseBadLogin(email, badLogins);
			}
			
			rs.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void resetBadLogins(String email) {
		try {
			Connection conn = getConnection();
			
			String sql = "UPDATE accountdetails SET bad_logins=? WHERE email='"+email+"';";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, 0);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void increaseBadLogin(String email, int badLogins) {
		try {
			Connection conn = getConnection();
			
			String sql = "UPDATE accountdetails SET bad_logins=? WHERE email='"+email+"';";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, badLogins+1);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void unlockAccount(String email) {
		try {
			Connection conn = getConnection();
			
			String sql = "UPDATE accountdetails SET account_status=?, locked_date=? WHERE email='"+email+"';";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, 1);
			stmt.setDate(2, null);
			stmt.executeUpdate();
			conn.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	
	public void lockAccount(String email) {
		try {
			long millis = System.currentTimeMillis();  
			Date currDate = new java.sql.Date(millis); 
			
			Connection conn = getConnection();
			
			String sql = "UPDATE accountdetails SET account_status=?, locked_date=? WHERE email='"+email+"';";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, 0);
			stmt.setDate(2, currDate);
			stmt.executeUpdate();
			conn.close();	
		}catch(Exception e){
			System.out.println(e);
		}
	}
	
	public String noamalizeSecurityAnswer(String secAns) {
		String result = secAns.replaceAll("[^A-Za-z0-9]",""); 
		return result;
	}
}
