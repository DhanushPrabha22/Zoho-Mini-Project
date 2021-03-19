package formbeans;

import javax.servlet.http.*;
import org.apache.struts.action.*;

import dao.JDBC_Operations;


public class ForgotPwdBean extends ActionForm{
	
	private String email, password, security;

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

	public String getSecurity() {
		return security;
	}

	public void setSecurity(String security) {
		this.security = security;
	}
	
	
	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		email = "";
		password = "";
		security = "";
	}
	
	
	@Override
	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		
		ActionErrors ae = new ActionErrors();
		
		JDBC_Operations jdbc = new JDBC_Operations();
		
		if(email.equals("")) {
			ae.add("email_e", new ActionMessage("msg1")); 
		}else if(password.equals("")) {
			ae.add("password_e", new ActionMessage("msg4")); 
		}else if(security.equals("")) {
			ae.add("security_e", new ActionMessage("msg6")); 
		}else {
			if(jdbc.isValid_Email(email)) {
				if(jdbc.isCheck_Email(email)) {
					if(password.length()>=6) {
						if(jdbc.isCheck_SecurityAnswer(email, security)) {
							jdbc.updatePassword(email, password);
						}else {
							ae.add("security_e", new ActionMessage("msg7")); 
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