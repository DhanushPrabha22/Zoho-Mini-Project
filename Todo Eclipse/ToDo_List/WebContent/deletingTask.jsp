<!--

deletingTask.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->

<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>To-Do</title>
</head>
<body>
<% 	
	int subFlag = Integer.parseInt(request.getParameter("subFlag"));
	int dateFlag = Integer.parseInt(request.getParameter("dateFlag"));
	int catFlag = Integer.parseInt(request.getParameter("catFlag"));
	
	int userId = Integer.parseInt(request.getParameter("userId"));
	int taskId = Integer.parseInt(request.getParameter("taskId"));
	
	if(userId!=-1){
		
		JDBC_List_Delete_Operations jdbcDelete = new JDBC_List_Delete_Operations();
		
		if(subFlag!=0){
			jdbcDelete.deleteSubTaskRecord(taskId);
		}
	
		if(dateFlag!=0){
			jdbcDelete.deleteDateRecord(taskId);
		}
	
		if(catFlag!=0){
			jdbcDelete.deleteCategoryRecord(taskId);
		}
		
		jdbcDelete.deleteTaskRecord(taskId);
		jdbcDelete.deleteTaskIdRecord(taskId);
		response.sendRedirect("UserTaskList.jsp");
	}
		
%>
	
</body>
</html>