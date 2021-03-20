<!--

myList.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.Period"%>
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
	int userId=-1, taskStatus, count=0, taskId=-1, importantStatus, flaggedStatus;
	String taskName="", description="";
	Date dateAdded;
%>

<header>
	
	<nav class="navbar navbar-expand-md navbar-dark" style="background-image: linear-gradient(-225deg, #FFAB91 50%, #78909C 50%)">
		<span style="font-size:30px; color: #818181; cursor:pointer" onclick="openNav()">&#9776;</span><br>
		<div class="emailId" id="emailId">
    		<a href="#" class="navbar-brand"><%=currUser%></a>
   		</div>
		<ul class="navbar-nav">
    		<li><a href="#" class="nav-link">Welcome</a></li>
    	</ul>
		<ul class="navbar-nav navbar-collapse justify-content-end">
			<li><a href="/ToDo_List/sign_in.jsp" class="nav-link">Logout</a></li>
		</ul>
	</nav>
</header>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <br><br><br><br><br>
  <a href="#">All Tasks</a>
  <a href="#">Important Tasks</a>
  <a href="#">Flagged Tasks</a>
  <a href="#">Planned</a>
</div>
<div id="main">
	<div>
		<div class="container1" id="container1">
			<h1>All Tasks</h1>
			<br>
			<div>
				<p><button class="w3-button w3-xlarge w3-circle w3-card-4" style="background-color:#818181;" id="myBtn">+</button>  Add Task...</p>
			</div>
			<div class="taskDiv">
			<div class="chunkedComponentList sticky">
			<div class="chunkedScrollContainer">
			<%
				JDBC_List_Operations jdbc = new JDBC_List_Operations();
				Connection conn = jdbc.getConnection();
				
				userId = jdbc.getUserId(currUser);
				
				try{
					
					String sql = "SELECT task_id_table.task_id, task_name, description, date_added, task_status, important_status, flagged_status "+
								 "FROM task_id_table "+
								 "INNER JOIN tasks_table ON "+
						    	 "(task_id_table.user_id=? AND task_id_table.task_id=tasks_table.task_id) "+
								 "ORDER BY date_added ASC";
					
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
						
						ResultSet rs1, rs2, rs3;
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
								<span>
									<span style="font-weight:bold; color:#3F51B5; font-size:135%" id="taskNameSpan<%=count%>">
										<%=taskName%>
									</span>
									<span id="taskDateSpan<%=count%>">
										| Created on <%=dateAdded%>
									</span>
									<span id="taskIdSpan<%=count%>" style="visibility:hidden">
										<%=taskId%>
									</span>
								</span>
							</span>
							<div class="metaDataInfo">
								<span class="metaDataInfo-group">
									<span>
										<span style="font-size:70%">
											<%=description%>
										</span>
									</span>
								</span>
							</div>
							<div class="metaDataInfo">
								<span class="metaDataInfo-group">
									<span>
										<span style="font-size:70%">
											<%=description%> <%=description%>
										</span>
									</span>
								</span>
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
			%>
			</div>
			</div>
			</div>
			<br><br>
		</div>
		
		<div class="container2">
			<div class="details">
				<div data-is-scrollable="true" class="details-body">
					<form action="updatingTasks.jsp" method="post">
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
						<div class="detailHeader-titleWrapper" style="text-align:center">
							<input type="submit" class="sign-up button1" value="Update"/>
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
    		<span class="close"></span>
      		<div class="field-set">
				<html:form action="adding" method="post">
				
					<html:errors property="taskname_e"/><br>
					<html:text styleClass="form-input1" property="taskName" styleId="taskName"/><br>
					
					<br>
					<html:text styleClass="form-input" property="description" styleId="description"/><br>
					<br>
					
					<html:submit styleClass="sign-up button1" value="Add"/>
				</html:form>
			</div>
  	</div>
</div>
</body>
</html>