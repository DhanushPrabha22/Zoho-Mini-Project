package actioncontrollers;

import javax.servlet.ServletContext;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import dao.JDBC_List_Operations;


public class UserTaskListController extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		form.reset(mapping,request);
		
		String taskName = request.getParameter("taskName");
		String description = request.getParameter("description");
		
		ServletContext context = request.getSession().getServletContext();
		String currUser = (String) context.getAttribute("currUser");
		
		JDBC_List_Operations jdbc = new JDBC_List_Operations();
		int userId = jdbc.getUserId(currUser);
		
		if(userId!=-1) {
			jdbc.insertTaskId(userId, taskName);
			int taskId = jdbc.getTaskId(userId, taskName);
			jdbc.insertTaskDetails(taskId, description);
		}
		
		return mapping.findForward("success");
	}
}
