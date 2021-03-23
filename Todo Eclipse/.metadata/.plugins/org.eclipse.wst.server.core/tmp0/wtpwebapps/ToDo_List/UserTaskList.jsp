<!--

UserTaskList.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.Period"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.ArrayList" %>
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
	int currPageId = (int) context.getAttribute("pageId");
	String sortColumn = (String) context.getAttribute("sortColumn");
	String sortOrder = (String) context.getAttribute("sortOrder");
	String wildCard = (String) context.getAttribute("wildCard");
	
	ArrayList<String> currTaskList = new ArrayList<String>();
	
	String bgColor="", mainTitle="";
	
	if(currPageId==0){
		bgColor = "#FFAB91";
		mainTitle = "All Tasks";
	}else if(currPageId==1){
		bgColor = "#FFF176";
		mainTitle = "Important Tasks";
	}else if(currPageId==2){
		bgColor = "#ef9a9a";
		mainTitle = "Flagged Tasks";
	}else if(currPageId==3){
		bgColor = "#A5D6A7";
		mainTitle = "Planned";
	}else if(currPageId==4){
		bgColor = "#BCAAA4";
		mainTitle = "Need Attention";
	}
	
	java.util.Date toadyDate = new java.util.Date();
	String dateFormatString = "EEE, MMM d, ''yy";
    DateFormat dateFormatM = new SimpleDateFormat(dateFormatString);
    String currentDate = dateFormatM.format(toadyDate);
%>

<header>
	
	<nav class="navbar navbar-expand-md navbar-dark" style="background-image: linear-gradient(-225deg, <%=bgColor%> 50%, #78909C 50%)">
		<span style="font-size:30px; color: #818181; cursor:pointer" onclick="openNav()" title="Open">&#9776;</span><br>
		<div class="emailId" id="emailId">
    		<a class="navbar-brand" style="color:white;" title="Hi"><%=currUser%></a>
   		</div>
		<ul class="navbar-nav">
    		<li><a class="nav-link" title="Welcome Again">Welcome</a></li>
    	</ul>
    	
    	<ul class="navbar-nav navbar-collapse justify-content-center">
    		<li>
				<button class="button1" style="height:40px;"  id="searchPopUpBtn" onClick="showSearchModal()" title="Search your Tasks">
					<i class="fa fa-search" style="float: left;maigin-top:3px;"></i>Search...</button>
			</li>
		</ul>
		
		<ul class="navbar-nav navbar-collapse justify-content-end">
			<li><a href="/ToDo_List/sign_in.jsp" class="nav-link" title="See you later">Logout</a></li>
		</ul>
	</nav>
</header>

<div id="mySidenav" class="sidenav" style="background-image: linear-gradient(-225deg, <%=bgColor%> 65%, #78909C 35%);">
  <a href="javascript:void(0)" class="closebtn" style="color:white;" onclick="closeNav()" title="Close">&times;</a>
  <br><br><br><br><br>
  <form action="redirectPage.jsp" method="post">
  	<input type="hidden" name="pageId" value="0"/>
  	<input type="submit" value="All Tasks"/>
  </form>
  <form action="redirectPage.jsp" method="post">
  	<input type="hidden" name="pageId" value="1"/>
  	<input type="submit" value="Important Tasks"/>
  </form>
  <form action="redirectPage.jsp" method="post">
  	<input type="hidden" name="pageId" value="2"/>
  	<input type="submit" value="Flagged Tasks"/>
  </form>
  <form action="redirectPage.jsp" method="post">
  	<input type="hidden" name="pageId" value="3"/>
  	<input type="submit" value="Planned"/>
  </form>
  <form action="redirectPage.jsp" method="post">
  	<input type="hidden" name="pageId" value="4"/>
  	<input type="submit" value="Need Attention"/>
  </form>
  <form action="" method="post">
  	<input type="submit" value="Category"/>
  </form>
</div>
<div id="main">
	<div>
		<div class="container1" id="container1">
			<div style="width:300px;">
				<h1 style="font-weight:bold;color:<%=bgColor%>;"><%=mainTitle%></h1>
				<p style="color:<%=bgColor%>;" title="Today"><%=currentDate%></p>
			</div>
			<div>
				<p style="color:<%=bgColor%>;"><button class="w3-button w3-xlarge w3-circle w3-card-4" style="background-color:#818181;" id="myBtn" title="Click to add a new Task">+</button>  Add New Task...</p>
			</div>
			<div class="metaDataInfo" style="margin-top:-15px;">
				<select id="sortColumn" name="sortColumn" form="sortForm" style="margin-right:8px;border:none;color:<%=bgColor%>;">
					<option selected value="task_name">TaskName</option>
					<option value="date_added">Date Added</option>
					<option value="task_status">Completed</option>
					<option value="catCount">Category</option>
					<option value="subCount">SubTasks</option>
				</select>
				<select id="sortOrder" name="sortOrder" form="sortForm" style="margin-right:8px;border:none;color:<%=bgColor%>;">
					<option selected value="ASC">Ascending</option>
					<option value="DESC">Descending</option>
				</select>
				<form action="redirectSort.jsp" id="sortForm"  method="post">
					<input type="text" class="form-input1" style="width:75px;margin-right:8px;height:30px;border-color:<%=bgColor%>" id="wildCard" name="wildCard" title="Enter Wildcard Characters"/>
					<input type="submit" style="width:50px;color:white;background-color:<%=bgColor%>;margin-top:30px;border:none;border-radius:4px;" value="Sort"/>
				</form>
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
					
					String sqlQuery = SqlQueryUtils.getQuery(sortColumn, sortOrder, wildCard, currPageId);
					
					PreparedStatement stmt = conn.prepareStatement(sqlQuery);
					stmt.setInt(1, userId);
					ResultSet rs = stmt.executeQuery();
					while (rs.next()){
						taskName = rs.getString("task_name");
						count++;
						currTaskList.add(taskName);
						taskId = rs.getInt("task_id");
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
							JDBC_List_SubTasks_Operations subJdbc = new JDBC_List_SubTasks_Operations();
							rsSubTask = subJdbc.getSubTaskRecord(taskId);
							if(!rsSubTask.equals("")){
								subTasksList = rsSubTask.split(",");
								subFlag++;
							}	
						}catch(Exception e){
						}
						
						//Category List
						try{
							JDBC_List_Flags_Operations catJdbc = new JDBC_List_Flags_Operations();
							rsCategory = catJdbc.getCategoryRecord(taskId);
							if(!rsCategory.equals("")){
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
   							 <label for="statusChk<%=count%>" title="Done"></label>
						</div>
			<%	
						}else{ 
			%>
						<div class="round">
							<input type="checkbox" id="statusChk<%=count%>" value="off" disabled/>
   							 <label for="statusChk<%=count%>" title="Not Done"></label>
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
										<span style="font-weight:bold; color:#3F51B5; font-size:135%" id="taskNameSpan<%=count%>" title="Task Name"><%=taskName%></span>
									</span>
			<%
						}else{
			%>
									<span style="font-weight:bold; color:#3F51B5; font-size:135%" id="taskNameSpan<%=count%>" title="Task Name"><%=taskName%></span>
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
								<span title="Sub Tasks" style="margin:2px;border:1px solid black;border-radius:2px;font-weight:bold; color:#3F51B5; font-size:75%;">
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
                        			<i class="fa fa-bell icon20" title="Remainder: <%=remainderDate%>"></i>
                        			<span id="remainderSpan<%=count%>" style="display:none"><%=remainderDate%></span>
								</div>
			<%
							}else{
			%>
								<div>
                        			<i class="fa fa-bell icon21" title="Remainder: <%=remainderDate%>"></i>
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
                        		<i class="fa fa-calendar icon20" title="Due on: <%=dueDate%>"></i>
                        		<span id="dueSpan<%=count%>" style="display:none"><%=dueDate%></span>
							</div>
			<%
							}else{
			%>
							<div>
                        		<i class="fa fa-calendar icon21" title="Due on: <%=dueDate%>"></i>
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
                        		<i class="fa fa-repeat icon20" title="Repeat"></i>
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
									<div title="Categories" style="margin:2px;border:1px solid black;border-radius:2px;">
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
										<i class="fa fa-file-text icon22" title="Description"></i>
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
   							 <label class="importantlabelShow" for="impStatusShow<%=count%>" title="Important"></label>
						</div>
						
			<%
						}else{
			%>
						<div style="margin-right:45px; margin-top:5px; margin-left:5px;">
							<input class="important" type="checkbox" id="impStatusShow<%=count%>" value="off" disabled/>
   							 <label class="importantlabelShow" for="impStatusShow<%=count%>" title="Not Important"></label>
						</div>
			<%
						}
						if(flaggedStatus==1){
			%>
						<div style="margin-right:45px; margin-left:-30px; margin-top:5px;">
							<input class="important" type="checkbox" id="flagStatusShow<%=count%>" value="on" checked disabled/>
   							 <label class="importantlabelShow2" for="flagStatusShow<%=count%>" title="Flagged"></label>
						</div>
						
			<%
						}else{
			%>
						<div style="margin-right:45px; margin-left:-30px; margin-top:5px;">
							<input class="important" type="checkbox" id="flagStatusShow<%=count%>" value="off" disabled/>
   							<label class="importantlabelShow2" for="flagStatusShow<%=count%>" title="Not Flagged"></label>
						</div>
			
			<%
						}
			%>
						<div style="margin-right:45px; margin-left:-20px;" title="Delete the task">
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
			<div class="details" style="background:<%=bgColor%>;">
				<div data-is-scrollable="true" class="details-body">
					<form action="updatingTasks.jsp" method="post">
						<input type="text" style="visibility:hidden" name="taskId" id="taskId" required/>
						<div class="detailHeader" style="border-radius:10px; margin-top:-25px;">
						<div class="detailHeader-titleWrapper">
							<div class="round" style="margin-top:-10px;margin-left:15px;">
								<input type="checkbox" name="taskStatus" id="taskStatus"/>
   							 	<label for="taskStatus" title="Task Status"></label>
							</div>
							<div class="detailHeader-title">
								<input type="text" class="form-input2" style="width:175px;" id="taskNameF" name="taskNameF" title="Task Name" readonly/>
							</div>
							<div style="margin-right:45px; margin-top:5px; margin-left:5px;">
								<input class="important" type="checkbox" name="importantFlag" id="impStatus"/>
   							 	<label class="importantlabel" for="impStatus" title="Important Status"></label>
							</div>
							<div style="margin-right:45px; margin-left:-30px; margin-top:5px;">
								<input class="important" type="checkbox" name="flaggedFlag" id="flagStatus"/>
   							 	<label class="importantlabel2" for="flagStatus" title="Flagged Status"></label>
							</div>
                        </div>
                        	<div class="input-container">
                        		<i class="fa fa-plus icon"></i>
                        		<input type="text" class="form-input2" style="width:300px;" id="subTasks" name="subTasks" title="Enter your Sub Tasks"/>
                        	</div>
                        </div>
                        <br>
                        <div class="detailHeader" style="border-radius:10px;">
                        	<div class="input-container">
                        		<i class="fa fa-bell icon"></i>
								<input type="text"  class="form-input2" onfocus="(this.type='date')" onblur="(this.type='text')" style="width:300px;" id="remainder" name="remainder" title="Remainder Date"/>
							</div>
							<div class="input-container">
                        		<i class="fa fa-calendar icon"></i>
								<input type="text" class="form-input2" onfocus="(this.type='date')" onblur="(this.type='text')" style="width:300px;" id="dueDate" name="dueDate" title="Due Date"/>
							</div>
							<div class="input-container">
                        		<i class="fa fa-repeat icon"></i>
								<input type="text" list="repeatings" class="form-input2" style="width:300px;" id="repeat" name="repeat" title="Repeat Type"/>
								<datalist id="repeatings">
  									<option value="Daily">
  									<option value="Weekly">
 									<option value="Monthly">
  									<option value="Yearly">
								</datalist>
							</div>
						</div>
						<br>
						<div class="detailHeader" style="border-radius:10px;">
							<div class="input-container">
                        		<i class="fa fa-tags icon"></i>
								<input type="text" list="categories" class="form-input2" style="height:40px;width:300px;" id="category" name="category" title="Pick your Category"/>
								<datalist id="categories">
  									<option value="Work">
  									<option value="Education">
 									<option value="Personal">
  									<option value="Friends">
  									<option value="Hobby">
								</datalist>
							</div>
						</div>
						 <br>
						 <div class="detailHeader" style="border-radius:10px;">
						 	<div class="input-container">
                        		<i class="fa fa-info-circle icon"></i>
								<input type="text" class="form-input2" style="height:60px;border-radius:0px;width:300px;" id="descriptionF" name="descriptionF" title="Enter your Description"/>
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

<div id="myModal" class="w3-modal">
  	<div class="w3-modal-content w3-animate-top w3-card-4">
      		<div class="field-set">
				<html:form action="adding" method="post">
				
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
  	<div class="w3-modal-content w3-animate-top w3-card-4">
      	<div class="field-set">
			<form action="deletingTask.jsp" method="post">
				<input type="hidden" name="taskId" id="taskIdDelete"/>
				<input type="text" class="form-input1" style="width:175px;font-weight:bold;" id="taskNameDelete" name="taskName" readonly/><br><br>
				<input type="submit" class="button1 sign-up" style="background-color:red;color:white;" value="DELETE"/>
			</form>
			<button class="button1" style="background:transparent;"  id="cancelDeleteTask">Cancel</button>
		</div>
  	</div>
</div>

<div id="searchModal" class="w3-modal">
  	<div class="w3-modal-content w3-animate-top w3-card-4">
      	<div class="field-set" style="text-align:center">
      		<div class="metaDataInfo" style="margin-bottom: 12px;">
      			<input type="text" id="searchedTask" onkeyup="showSearchedTask()" placeholder="Search your tasks.." title="Type your task name">
   				<button class="button1" style="width: 15%;background:#CFD8DC;margin-left:8px;border-radius:20px;"  id="cancelSearchModal">Cancel</button>
   			</div>
   			<table id="searchTable">
   			<%
   				for(int i=1;i<= currTaskList.size(); i++){
   			%>
   				<tr id="searchTableRow<%=i%>" onClick="finalSearchMethod(this.id)" style="width:75%;text-align:center">
    				<td><%=currTaskList.get(i-1)%></td>
  				</tr>
  			<%
   				}
  			%>	
   			</table>
   			
   		</div>
   	</div>
</div>
</body>
</html>