<!--

forgotPwd.jsp

java version "1.8.0_45"

Created By Dhanush L
                 
-->

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html>
<html>
<head>
	<title>To-Do</title>
	<link rel="icon" href="resources/appIcon.png">
	<link rel="stylesheet" type="text/css" href="styles/sign_in.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="scripts/forgotPwd.js"></script>
</head>
<body>
	<div class="main-div">
		<!--   con = Container  for items in the form-->
		<div class="con">
			<!--     Start  header Content  -->
			<header class="head-form">
				<h2>NEW PASSWORD</h2>
				<!--     A welcome message or an explanation of the login form -->
				<br>
				<p><b>Enter your registered Email and Password</b></p>
			</header>
			<br>
			<div class="field-set">
				<html:form action="forgotpwd" method="post">
				
					<!--user name -->
					<html:errors property="email_e"/><br>
					<span class="input-item"><i class="fa fa-user-circle"></i></span>
					<html:text styleClass="form-input" property="email" styleId="email"/><br>
					
					<!--Password -->
					<html:errors property="password_e"/><br>
					<span class="input-item"><i class="fa fa-key"></i></span>
					<html:password styleClass="form-input" property="password" styleId="pwd"/><br>
					
					<!--Security -->
					<html:errors property="security_e"/><br>
					<div class="tooltip">
						<span class="input-item"><i class="fa fa-shield"></i></span>
						<span class="tooltiptext"><b>Enter the correct answer</b><br><br><b>1.</b> What is your favorite sport?<br><b>2.</b> What is your pet name?<br><b>3.</b> What is your favorite city?</span>
					</div>
					<html:text styleClass="form-input" property="security" styleId="sec"/>
					
					<br><br><br>
					<html:submit styleClass="sign-up button" value="Change"/>
				</html:form>
				<button class="button frgt-pass" onclick="cancel()">Cancel</button>
			</div>
		<!--   End Container  -->
		</div>
	<!-- End Form -->
	</div>
</body>
</html>