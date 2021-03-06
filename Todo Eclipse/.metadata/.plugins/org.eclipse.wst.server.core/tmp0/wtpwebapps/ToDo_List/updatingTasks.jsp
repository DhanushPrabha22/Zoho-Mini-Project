<!--

updatingTasks.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->

<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.Period"%>

<!DOCTYPE html>
<html>
<head>
<title>To-Do</title>
</head>
<body>
	<%
	    JDBC_List_Operations jdbc = new JDBC_List_Operations();
		JDBC_List_Flags_Operations jdbcFlags = new JDBC_List_Flags_Operations();
		JDBC_List_SubTasks_Operations jdbcSubTasks = new JDBC_List_SubTasks_Operations();
		JDBC_List_Dates_Operations jdbcDates = new JDBC_List_Dates_Operations();
		
		
		int  taskId=-1, taskStatus=-1, importantFlag=0, flaggedFlag=0;
		String description="", repeat=null;
		String[] temp={};
		java.sql.Date remainder=null, dueDate=null;
		
		if(!request.getParameter("taskNameF").equals("")){
			taskId = Integer.parseInt(request.getParameter("taskId"));
			try{
				if(request.getParameter("taskStatus").equals("on"))
					taskStatus=1;
					
			}catch(Exception e){
				taskStatus=0;
			}
			try{
				if(request.getParameter("importantFlag").equals("on"))
					importantFlag=1;
			}catch(Exception e){
				importantFlag=0;
			}
			try{
				if(request.getParameter("flaggedFlag").equals("on"))
					flaggedFlag=1;
			}catch(Exception e){
				flaggedFlag=0;
			}
			if(!request.getParameter("descriptionF").equals("")){
				String noSpace = request.getParameter("descriptionF").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				description += noSpace;
			}
			
			//Status and Description Update
			jdbc.updateTaskDetails(taskId, description, taskStatus, importantFlag, flaggedFlag); 
			
			int flag=0;
			if(!request.getParameter("category").equals("")){
				
				String noSpace = request.getParameter("category").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				noSpace = noSpace.replaceAll("[^A-Za-z0-9 ]","");
		        
				if(noSpace.length()>0){
					temp = noSpace.split("\\s+");
					if(temp.length>0){
						flag++;
					}
				}
			}
			
			//Flags Operations
			if(!jdbcFlags.isCheck_Task_Id(taskId)){
				if(flag!=0)
					jdbcFlags.insertFlagRecord(taskId, temp);
			}else{
				if(flag!=0){
					jdbcFlags.updateFlagRecord(taskId, temp);
				}else{
					jdbcFlags.deleteFlagRecord(taskId);
				}
			}
			
			flag=0;
			if(!request.getParameter("subTasks").equals("")){
				
				String noSpace = request.getParameter("subTasks").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				noSpace = noSpace.replaceAll("[^A-Za-z0-9 ]","");
				
				if(noSpace.length()>0){
					temp = noSpace.split("\\s+");
					if(temp.length>0){
						flag++;
					}
				}
			}
			
			//SubTasks Operations
			if(!jdbcSubTasks.isCheck_Task_Id(taskId)){
				if(flag!=0)
					jdbcSubTasks.insertSubTaskRecord(taskId, temp);
			}else{
				if(flag!=0)
					jdbcSubTasks.updateSubTaskRecord(taskId, temp);
				else
					jdbcSubTasks.deleteSubTaskRecord(taskId);
			}
			
			flag=0;
			if(!request.getParameter("repeat").equals("")){
				
				String noSpace = request.getParameter("repeat").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				noSpace = noSpace.replaceAll("[^A-Za-z0-9 ]","");
				
				if(noSpace.length()>0){
					repeat="";
					repeat += noSpace;
					flag++;
				}
			}
			if(!request.getParameter("remainder").equals("")){
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = sdf1.parse(request.getParameter("remainder"));
				remainder = new java.sql.Date(date.getTime());
				flag++;
			}
			if(!request.getParameter("dueDate").equals("")){
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = sdf1.parse(request.getParameter("dueDate"));
				dueDate = new java.sql.Date(date.getTime()); 
				flag++;
			}
			
			//Task Dates Operations
			if(!jdbcDates.isCheck_Task_Id(taskId)){
				if(flag!=0)
					jdbcDates.insertDatesRecord(taskId, dueDate, repeat, remainder);
			}else{
				if(flag!=0)
					jdbcDates.updateDatesRecord(taskId, dueDate, repeat, remainder);
				else
					jdbcDates.deleteDatesRecord(taskId);
			}
		}
		response.sendRedirect("UserTaskList.jsp");
	%>
	
</body>
</html>