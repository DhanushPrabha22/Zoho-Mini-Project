<!--

redirectPage.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->
<!DOCTYPE html>
<html>
<head>
<title>To-Do</title>
</head>
<body>
<%
	int pageId = Integer.parseInt(request.getParameter("pageId"));
	ServletContext context = request.getSession().getServletContext();
	context.setAttribute("pageId", pageId);
	
	response.sendRedirect("UserTaskList.jsp");
%>
</body>
</html>