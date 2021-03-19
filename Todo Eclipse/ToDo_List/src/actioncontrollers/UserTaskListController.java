package actioncontrollers;

import javax.servlet.ServletContext;
import javax.servlet.http.*;
import org.apache.struts.action.*;


public class UserTaskListController extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		form.reset(mapping,request);
		return mapping.findForward("success");
	}
}
