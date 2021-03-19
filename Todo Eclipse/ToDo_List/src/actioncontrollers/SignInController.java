package actioncontrollers;

import javax.servlet.ServletContext;
import javax.servlet.http.*;
import org.apache.struts.action.*;


public class SignInController extends Action  {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");
		ServletContext context = request.getSession().getServletContext();
		context.setAttribute("currUser", email );
		form.reset(mapping,request);
		return mapping.findForward("success");
	}
	
}