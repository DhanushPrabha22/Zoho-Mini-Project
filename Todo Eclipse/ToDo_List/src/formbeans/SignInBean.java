package formbeans;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import dao.JDBC_Operations;

public class SignInBean extends ActionForm  {
	
	private String email, password;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		email = "";
		password = "";
	}
	

	@Override
	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		
		ActionErrors ae = new ActionErrors();
		
		JDBC_Operations jdbc = new JDBC_Operations();
		
		if(email.equals("")) {
			ae.add("email_e", new ActionMessage("msg1")); 
		}else if(password.equals("")) {
			ae.add("password_e", new ActionMessage("msg4")); 
		}else {
			if(jdbc.isValid_Email(email)) {
				if(jdbc.isCheck_Email(email)) {
					if(password.length()>=6) {
						if(jdbc.isCheck_Password(email, password)) {
							if(jdbc.isCheckStatus(email, password)) {
								//No Incorrect Data
							}else {
								ae.add("email_e", new ActionMessage("msg8")); 
							}
						}else {
							if(jdbc.isCheckStatus(email, password)) {
								jdbc.updateBadLogins(email);
							}
							ae.add("password_e", new ActionMessage("msg5"));
						}
					}else {
						ae.add("password_e", new ActionMessage("msg4")); 
					}
				}else {
					ae.add("email_e", new ActionMessage("msg2")); 
				}
			}else {
				ae.add("email_e", new ActionMessage("msg1"));
			}
		}
		
		return ae;
	}
	
	
}
