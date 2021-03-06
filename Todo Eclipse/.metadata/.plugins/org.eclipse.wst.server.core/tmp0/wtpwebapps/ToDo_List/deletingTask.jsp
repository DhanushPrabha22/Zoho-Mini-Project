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
	ServletContext context = request.getSession().getServletContext();
	String currUser = (String) context.getAttribute("currUser");
	JDBC_List_Operations jdbc = new JDBC_List_Operations();
	int userId = jdbc.getUserId(currUser);
	
	int taskId = Integer.parseInt(request.getParameter("taskId"));
	
	JDBC_List_SubTasks_Operations subObj = new JDBC_List_SubTasks_Operations();
	JDBC_List_Dates_Operations dateObj = new JDBC_List_Dates_Operations();
	JDBC_List_Flags_Operations catObj = new JDBC_List_Flags_Operations();
	
	if(userId!=-1){
		
		JDBC_List_Delete_Operations jdbcDelete = new JDBC_List_Delete_Operations();
		
		if(subObj.isCheck_Task_Id(taskId)){
			jdbcDelete.deleteSubTaskRecord(taskId);
		}
	
		if(dateObj.isCheck_Task_Id(taskId)){
			jdbcDelete.deleteDateRecord(taskId);
		}
	
		if(catObj.isCheck_Task_Id(taskId)){
			jdbcDelete.deleteCategoryRecord(taskId);
		}
		
		jdbcDelete.deleteTaskRecord(taskId);
		jdbcDelete.deleteTaskIdRecord(taskId);
		response.sendRedirect("UserTaskList.jsp");
	}
		
%>
	
</body>
</html>