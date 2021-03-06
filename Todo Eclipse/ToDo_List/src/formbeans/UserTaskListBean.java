package formbeans;

import javax.servlet.ServletContext;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import dao.*;


public class UserTaskListBean extends ActionForm {
		
		private String taskName, description;

		public String getTaskName() {
			return taskName;
		}

		public void setTaskName(String taskName) {
			this.taskName = taskName;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}
		

		@Override
		public void reset(ActionMapping mapping, HttpServletRequest request) {
			taskName = "";
			description = "";
		}
		
		
		@Override
		public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
			
			ActionErrors ae = new ActionErrors();
			
			if(taskName.equals("")) {
				ae.add("taskname_e", new ActionMessage("msg9")); 
			}
			
			return ae;
		}
}
