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
	int userId=-1, taskStatus, count=0;
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
					String sql = "SELECT task_name, description, date_added, task_status FROM task_id_table "+
								 "INNER JOIN tasks_table ON "+
						    	 "(task_id_table.user_id=? AND task_id_table.task_id=tasks_table.task_id) "+
								 "ORDER BY task_name ASC";
					PreparedStatement stmt = conn.prepareStatement(sql);
					stmt.setInt(1, userId);
					ResultSet rs = stmt.executeQuery();
					while (rs.next()){
						count++;
						taskName = rs.getString("task_name");
						description = rs.getString("description");
						dateAdded = rs.getDate("date_added");
						taskStatus = rs.getInt("task_status");
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
							<input type="checkbox" id="checkbox" checked disabled/>
   							 <label for="checkbox"></label>
						</div>
			<%	
						}else{ 
			%>
						<div class="round">
							<input type="checkbox" id="checkbox" disabled/>
   							 <label for="checkbox"></label>
						</div>
						
			<% 
						}
			%>			
						</div>
						<button tabindex="0" class="taskItem-titleWrapper">
							<span class="taskItem-title">
								<span>
									<span>
										<%=taskName%>
									</span>
								</span>
							</span>
							<div class="metaDataInfo">
								<span class="metaDataInfo-group">
									<span>
										<span>
											<%=description%>
										</span>
									</span>
								</span>
							</div>
						</button>
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
					<h3 style="color:#78909C; text-align:center; font-weight:bold">Update your tasks here...</h3>
					<br>
					<form action="updatingTasks.jsp" method="post">
						<input type="hidden" name="userId" value="<%=userId%>"/>
						
						<input type="checkbox" name="taskStatus"/>
						<input type="text" class="form-input1" id="taskName" name="taskName"/>
						<input type="checkbox" name="importantFlag"/>
                        <input type="checkbox" name="flaggedFlag"/>
						<input type="text" class="form-input1" id="subTasks" name="subTasks"/>
						<input type="text" class="form-input1" id="remainder" name="remainder"/>
						<input type="text" class="form-input1" id="dueDate" name="dueDate"/>
						<input type="text" class="form-input1" id="repeat" name="repeat"/>
						<input type="text" class="form-input1" id="category" name="category"/>
						<input type="text" class="form-input" id="description" name="description"/>
						<br><br><br>
						<input type="submit" class="sign-up button1" value="Update"/>
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