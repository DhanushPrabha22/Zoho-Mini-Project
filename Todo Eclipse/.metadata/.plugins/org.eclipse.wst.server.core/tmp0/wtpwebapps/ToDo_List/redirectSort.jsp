<!--

redirectSort.jsp

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
	String sortColumn = request.getParameter("sortColumn");
	String sortOrder = request.getParameter("sortOrder");
	String wildCard = request.getParameter("wildCard");
	String catValue = request.getParameter("catValue");
	ServletContext context = request.getSession().getServletContext();
	context.setAttribute("sortColumn", sortColumn);
	context.setAttribute("sortOrder", sortOrder);
	context.setAttribute("wildCard", wildCard);
	context.setAttribute("catValue", catValue);
	
	response.sendRedirect("UserTaskList.jsp");
%>

<%=sortColumn %>
<%=sortOrder %>
<%=wildCard %>
</body>
</html>