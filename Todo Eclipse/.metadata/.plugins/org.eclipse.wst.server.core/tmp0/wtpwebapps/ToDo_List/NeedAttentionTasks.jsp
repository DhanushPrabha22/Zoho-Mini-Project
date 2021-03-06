<!--

NeedAttentionTasks.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.Period"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<!DOCTYPE>
<html>
<head>
	<title>To-Do</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="resources/appIcon.png">
	<link rel="stylesheet" type="text/css" href="styles/myList.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="scripts/myList.js"></script>
</head>
<body>
<%
	ServletContext context = request.getSession().getServletContext();
	String currUser = (String) context.getAttribute("currUser");
	java.util.Date toadyDate = new java.util.Date();
	String dateFormatString = "EEE, MMM d, ''yy";
    DateFormat dateFormatM = new SimpleDateFormat(dateFormatString);
    String currentDate = dateFormatM.format(toadyDate);
%>

<header>
	
	<nav class="navbar navbar-expand-md navbar-dark" style="background-image: linear-gradient(-225deg, #BCAAA4 50%, #78909C 50%)">
		<span style="font-size:30px; color: #818181; cursor:pointer" onclick="openNav()">&#9776;</span><br>
		<div class="emailId" id="emailId">
    		<a class="navbar-brand" style="color:white;"><%=currUser%></a>
   		</div>
		<ul class="navbar-nav">
    		<li><a class="nav-link">Welcome</a></li>
    	</ul>
		<ul class="navbar-nav navbar-collapse justify-content-end">
			<li><a href="/ToDo_List/sign_in.jsp" class="nav-link">Logout</a></li>
		</ul>
	</nav>
</header>

<div id="mySidenav" class="sidenav" style="background-image: linear-gradient(-225deg, #BCAAA4 65%, #78909C 35%);">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <br><br><br><br><br>
  <a href="UserTaskList.jsp">All Tasks</a>
  <a href="importantTaskList.jsp">Important Tasks</a>
  <a href="flaggedTaskList.jsp">Flagged Tasks</a>
  <a href="PlannedTaskList.jsp">Planned</a>
  <a style="color: #1565C0;">Need Attention</a>
  <div  class="sidenavin metaDataInfo" style="margin:8px;">
  	<div>
     	<i class="fa fa-calendar"></i>
	</div>
	<div>
       	<i class="fa fa-calendar"></i>
	</div>
	<div>
       	<i class="fa fa-calendar"></i>
	</div>
	<div>
       	<i class="fa fa-calendar"></i>
	</div>
  </div>
</div>
<div id="main">
	<div>
		<div class="container1" id="container1">
			<h1 style="font-weight:bold;color:#BCAAA4;">Need Attention</h1>
			<p style="color:#BCAAA4;"><%=currentDate%></p>
			<div>
				<p style="color:#BCAAA4;"><button class="w3-button w3-xlarge w3-circle w3-card-4" style="background-color:#818181;" id="myBtn">+</button>  Add Task...</p>
			</div>
			<div class="taskDiv">
			<div class="chunkedComponentList sticky">
			<div class="chunkedScrollContainer">
			<%
				JDBC_List_Operations jdbc = new JDBC_List_Operations();
				Connection conn = jdbc.getConnection();
				
				int userId=-1, taskStatus, count=0, taskId=-1, importantStatus, flaggedStatus;
				String taskName="", description="", repeatStatus="";
				String[] categoryList={}, subTasksList={};
				java.sql.Date dateAdded=null, dueDate=null, remainderDate=null;
				
				userId = jdbc.getUserId(currUser);
				
				if(userId!=-1){
				
				try{
					
					String sql = "SELECT  task_id_table.task_id, task_name, description, date_added, task_status, important_status, "+
								 "flagged_status, due_date, repeat_status, remainder_date, subtask_list, category_list "+
								 "FROM task_id_table INNER JOIN tasks_table ON "+
								 "(task_id_table.user_id = ? AND task_id_table.task_id = tasks_table.task_id) "+
								 "INNER JOIN task_dates ON "+
						    	 "(task_dates.task_id = task_id_table.task_id AND task_dates.task_id IN "+
								 "(SELECT task_dates.task_id FROM task_dates WHERE "+
						    	 "DATEDIFF( CURDATE(), remainder_date)>0 OR "+
								 "DATEDIFF( CURDATE(), due_date)>0)) "+
						    	 "LEFT JOIN subtasks_table ON "+
						    	 "(subtasks_table.task_id = task_id_table.task_id) "+
						    	 "LEFT JOIN category_table ON "+
						    	 "(category_table.task_id = task_id_table.task_id) "+
								 "ORDER BY task_name ASC;";
					
					PreparedStatement stmt = conn.prepareStatement(sql);
					stmt.setInt(1, userId);
					ResultSet rs = stmt.executeQuery();
					while (rs.next()){
						count++;
						
						taskId = rs.getInt("task_id");
						taskName = rs.getString("task_name");
						description = rs.getString("description");
						dateAdded = rs.getDate("date_added");
						taskStatus = rs.getInt("task_status");
						importantStatus = rs.getInt("important_status");
						flaggedStatus = rs.getInt("flagged_status");
						
						int subFlag=0, dateFlag=0, catFlag=0;
						String[] rsDates = {"","",""};
						String rsCategory = "", rsSubTask="";
						
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
						
						//Remainder Date
						try{
							remainderDate = rs.getDate("remainder_date");
							rsDates[0] = dateFormat.format(remainderDate);  
							dateFlag++;
						}catch(Exception e){
							rsDates[0] = "";
						}
						//Due Date
						try{
							dueDate = rs.getDate("due_date");
							rsDates[1] = dateFormat.format(dueDate);  
							dateFlag++;
						}catch(Exception e){
							rsDates[1] = "";
						}
						//Repeat Status
						try{
							repeatStatus = rs.getString("repeat_status");
							if(repeatStatus!=null){
								rsDates[2] = repeatStatus;
								dateFlag++;
							}
							else
								rsDates[2] = "";
						}catch(Exception e){
							rsDates[2] = "";
						}
						
						//SubTasks List
						try{
							rsSubTask = rs.getString("subtask_list");
							if(rsSubTask!=null){
								subTasksList = rsSubTask.split(",");
								subFlag++;
							}	
						}catch(Exception e){
						}
						
						//Category List
						try{
							rsCategory = rs.getString("category_list");
							if(rsCategory!=null){
								categoryList = rsCategory.split(",");
								catFlag++;
							}
						}catch(Exception e){
						}
			%>
					<div>
					<div role="none">
					<div class="taskItem">
					<div class="taskItem-body">
						<div>
			<%
						if(taskStatus==1){
			%>
						<div class="round">
							<input type="checkbox" id="statusChk<%=count%>" value="on" checked disabled/>
   							 <label for="statusChk<%=count%>"></label>
						</div>
			<%	
						}else{ 
			%>
						<div class="round">
							<input type="checkbox" id="statusChk<%=count%>" value="off" disabled/>
   							 <label for="statusChk<%=count%>"></label>
						</div>
						
			<% 
						}
			%>			
						</div>
						<button tabindex="0" class="taskItem-titleWrapper" id="taskBtn<%=count%>" onclick="updateTask(this.id)">
							<span class="taskItem-title">
			<%
						if(taskStatus==1){
			%>
								<span>
									<span style='color:#000;text-decoration:line-through;'>
										<span style="font-weight:bold; color:#3F51B5; font-size:135%" id="taskNameSpan<%=count%>"><%=taskName%></span>
									</span>
			<%
						}else{
			%>
									<span style="font-weight:bold; color:#3F51B5; font-size:135%" id="taskNameSpan<%=count%>"><%=taskName%></span>
			<%
						}
			%>
								<span style="margin-left:10px;">
			<% 
						if(subFlag!=0){
							String sub = "";
							for(int i=0; i<subTasksList.length; i++){
								sub += subTasksList[i] + " ";
			%>
								<span style="margin:2px;border:1px solid black;border-radius:2px;font-weight:bold; color:#3F51B5; font-size:75%;">
									<span style="font-size:70%; margin:1px"><%=subTasksList[i]%></span>
								</span>
								
			<%
							}
			%>
							</span>
								<span style="display:none;" id="subTaskSpan<%=count%>"><%=sub%></span>
			<%				
						}else{
			%>
								<span>
									<span style="display:none" id="subTaskSpan<%=count%>"></span>
								</span>
			<%
						}
			%>
									<span style="margin-left:10px;" id="taskDateSpan<%=count%>">Created on <%=dateAdded%></span>
									<span id="taskIdSpan<%=count%>" style="visibility:hidden"><%=taskId%></span>
								</span>
							</span>
							
							<div class="metaDataInfo" style="margin-top:-8px;margin-bottom:-8px;">
			<%
					long millis = System.currentTimeMillis();  
					java.sql.Date currDate = new java.sql.Date(millis); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
					if(!rsDates[0].equals("")){
						
						try{
							java.util.Date date = sdf.parse(rsDates[0]);
							int years=0, months=0, days=0;
							Period age = Period.between(remainderDate.toLocalDate(), currDate.toLocalDate());
							years = age.getYears(); 
							months = age.getMonths();
							days = age.getDays();
							if(years<0 || months<0 || days<=0) {
			%>
								<div>
                        			<i class="fa fa-bell icon20"></i>
                        			<span id="remainderSpan<%=count%>" style="display:none"><%=remainderDate%></span>
								</div>
			<%
							}else{
			%>
								<div>
                        			<i class="fa fa-bell icon21"></i>
                        			<span id="remainderSpan<%=count%>" style="display:none"><%=remainderDate%></span>
								</div>
			<%
							}
						}catch(Exception e){
							System.out.println(e);
						}
					}else{
			%>
								<div>
                        			<span id="remainderSpan<%=count%>" style="display:none"></span>
								</div>
			<%
					}
					if(!rsDates[1].equals("")){
						try{
							java.util.Date date = sdf.parse(rsDates[1]);
							int years=0, months=0, days=0;
							Period age = Period.between(dueDate.toLocalDate(), currDate.toLocalDate());
							years = age.getYears(); 
							months = age.getMonths();
							days = age.getDays();
							if(years<0 || months<0 || days<=0) {
			%>
							<div>
                        		<i class="fa fa-calendar icon20"></i>
                        		<span id="dueSpan<%=count%>" style="display:none"><%=dueDate%></span>
							</div>
			<%
							}else{
			%>
							<div>
                        		<i class="fa fa-calendar icon21"></i>
                        		<span id="dueSpan<%=count%>" style="display:none"><%=dueDate%></span>
							</div>
			<%
							}
						}catch(Exception e){
							System.out.println(e);
						}
					}else{
			%>
							<div>
                        		<span id="dueSpan<%=count%>" style="display:none"></span>
							</div>
			<%
					}
					if(!rsDates[2].equals("")){
			%>
							<div>
                        		<i class="fa fa-repeat icon20"></i>
                        		<span id="repeat<%=count%>" style="margin-left:-12px;font-size:70%;color:#FFAB91"><%=repeatStatus%></span>
							</div>
			<%
					}else{
			%>
							<div>
                        		<span id="repeat<%=count%>" style="display:none"></span>
							</div>
			<%
					}
			%>
							</div>
							<div class="metaDataInfo" style="margin-top:10px;">
								
								<div class="metaDataInfo">
			<%
					if(catFlag!=0){
						String cat = "";
						for(int i=0; i<categoryList.length; i++){
							cat += categoryList[i] + " ";
			%>
									<div style="margin:2px;border:1px solid black;border-radius:2px;">
										<span style="font-size:70%; margin:1px"><%=categoryList[i]%></span>
									</div>
			<%
						}
						
			%>
									<span style="display:none" id="categorySpan<%=count%>"><%=cat%></span>
			<% 
					}else{
			%>					
									<div>
										<span style="display:none" id="categorySpan<%=count%>"></span>
									</div>
								</div>
								<div>
			<%
					}
					if(!description.equals("")){
			%>						
									<div>
										<i class="fa fa-file-text icon22"></i>
										<span style="display:none" id="taskDescriptionSpan<%=count%>"><%=description%></span>
									</div>
			<%
					}else{
			%>
									<div>
										<span style="display:none" id="taskDescriptionSpan<%=count%>"></span>
									</div>
			<%
					}
			%>
								</div>
							</div>
						</button>
			<%
						if(importantStatus==1){
			%>
						<div style="margin-right:45px; margin-top:5px; margin-left:5px;">
							<input class="important" type="checkbox" id="impStatusShow<%=count%>" value="on" checked disabled/>
   							 <label class="importantlabelShow" for="impStatusShow<%=count%>"></label>
						</div>
						
			<%
						}else{
			%>
						<div style="margin-right:45px; margin-top:5px; margin-left:5px;">
							<input class="important" type="checkbox" id="impStatusShow<%=count%>" value="off" disabled/>
   							 <label class="importantlabelShow" for="impStatusShow<%=count%>"></label>
						</div>
			<%
						}
						if(flaggedStatus==1){
			%>
						<div style="margin-right:45px; margin-left:-30px; margin-top:5px;">
							<input class="important" type="checkbox" id="flagStatusShow<%=count%>" value="on" checked disabled/>
   							 <label class="importantlabelShow2" for="flagStatusShow<%=count%>"></label>
						</div>
						
			<%
						}else{
			%>
						<div style="margin-right:45px; margin-left:-30px; margin-top:5px;">
							<input class="important" type="checkbox" id="flagStatusShow<%=count%>" value="off" disabled/>
   							<label class="importantlabelShow2" for="flagStatusShow<%=count%>"></label>
						</div>
			
			<%
						}
			%>
						<div style="margin-right:45px; margin-left:-20px;">
							<i class="fa fa-trash" style="cursor: pointer;color:red;" id="deleteBox" onClick="deleteTask(<%=taskId%>, '<%=taskName%>', <%=subFlag%>, <%=dateFlag%>, <%=catFlag%>)"> Delete</i>
						</div>
					</div>
					</div>
					</div>
					</div>
			<%
					}
					rs.close();
					conn.close();
				}catch(Exception e){
					System.out.println(e);
				}
			}else{
				response.sendRedirect("/ToDo_List/");
			}
			%>
			</div>
			</div>
			</div>
			<br><br>
		</div>
		
		<div class="container2">
			<div class="details"  style="background:#BCAAA4;">
				<div data-is-scrollable="true" class="details-body">
					<form action="updatingTasks.jsp" method="post">
						<input type="hidden" name="pageId" value="4"/>
						<input type="hidden" name="userId" value="<%=userId%>"/>
						<input type="text" style="visibility:hidden" name="taskId" id="taskId" required/>
						<div class="detailHeader" style="border-radius:10px; margin-top:-25px;">
						<div class="detailHeader-titleWrapper">
							<div class="round" style="margin-top:-10px;margin-left:15px;">
								<input type="checkbox" name="taskStatus" id="taskStatus"/>
   							 	<label for="taskStatus"></label>
							</div>
							<div class="detailHeader-title">
								<input type="text" class="form-input2" style="width:175px;" id="taskNameF" name="taskNameF" readonly/>
							</div>
							<div style="margin-right:45px; margin-top:5px; margin-left:5px;">
								<input class="important" type="checkbox" name="importantFlag" id="impStatus"/>
   							 	<label class="importantlabel" for="impStatus"></label>
							</div>
							<div style="margin-right:45px; margin-left:-30px; margin-top:5px;">
								<input class="important" type="checkbox" name="flaggedFlag" id="flagStatus"/>
   							 	<label class="importantlabel2" for="flagStatus"></label>
							</div>
                        </div>
                        	<div class="input-container">
                        		<i class="fa fa-plus icon"></i>
                        		<input type="text" class="form-input2" style="width:300px;" id="subTasks" name="subTasks"/>
                        	</div>
                        </div>
                        <br>
                        <div class="detailHeader" style="border-radius:10px;">
                        	<div class="input-container">
                        		<i class="fa fa-bell icon"></i>
								<input type="text"  class="form-input2" onfocus="(this.type='date')" onblur="(this.type='text')" style="width:300px;" id="remainder" name="remainder"/>
							</div>
							<div class="input-container">
                        		<i class="fa fa-calendar icon"></i>
								<input type="text" class="form-input2" onfocus="(this.type='date')" onblur="(this.type='text')" style="width:300px;" id="dueDate" name="dueDate"/>
							</div>
							<div class="input-container">
                        		<i class="fa fa-repeat icon"></i>
								<input type="text" class="form-input2" style="width:300px;" id="repeat" name="repeat"/>
							</div>
						</div>
						<br>
						<div class="detailHeader" style="border-radius:10px;">
							<div class="input-container">
                        		<i class="fa fa-tags icon"></i>
								<input type="text" class="form-input2" style="height:40px;width:300px;" id="category" name="category"/>
							</div>
						</div>
						 <br>
						 <div class="detailHeader" style="border-radius:10px;">
						 	<div class="input-container">
                        		<i class="fa fa-info-circle icon"></i>
								<input type="text" class="form-input2" style="height:60px;border-radius:0px;width:300px;" id="descriptionF" name="descriptionF"/>
						 	</div>
						 </div>
						<br>
						<div style="text-align:center;">
							<input type="submit" class="button1 sign-up" value="Update"/>
						</div>
					</form> 
				</div>
			</div>
		</div>
	</div>
</div>
<!-- The Modal -->
<div id="myModal" class="w3-modal">
  	<!-- Modal content -->
  	<div class="w3-modal-content w3-animate-top w3-card-4">
      		<div class="field-set">
				<html:form action="addingFour" method="post">
				
					<html:hidden property="userId" styleId="userId" value="<%=String.valueOf(userId)%>"/>
					
					<html:errors property="taskname_e"/><br>
					<html:text styleClass="form-input1" property="taskName" styleId="taskName"/><br>
					
					<br>
					<html:text styleClass="form-input" property="description" styleId="description"/><br>
					<br>
					
					<html:submit styleClass="sign-up button1" value="Add"/>
				</html:form>
				<button class="button1" style="background:transparent;" id="cancelAddTask">Cancel</button>
			</div>
  	</div>
</div>

<div id="deleteModal" class="w3-modal">
  	<!-- Modal content -->
  	<div class="w3-modal-content w3-animate-top w3-card-4">
      	<div class="field-set">
			<form action="deletingTask.jsp" method="post">
				<input type="hidden" name="pageId" value="4"/>
				<input type="hidden" name="userId" value="<%=userId%>"/>
				<input type="hidden" name="taskId" id="taskIdDelete"/>
				<input type="hidden" name="subFlag" id="subFlagDelete"/>
				<input type="hidden" name="dateFlag" id="dateFlagDelete"/>
				<input type="hidden" name="catFlag" id="catFlagDelete"/>
				<input type="text" class="form-input1" style="width:175px;font-weight:bold;" id="taskNameDelete" name="taskName" readonly/><br><br>
				<input type="submit" class="button1 sign-up" style="background-color:red;color:white;" value="DELETE"/>
			</form>
			<button class="button1" style="background:transparent;"  id="cancelDeleteTask">Cancel</button>
		</div>
  	</div>
</div>
</body>
</html>