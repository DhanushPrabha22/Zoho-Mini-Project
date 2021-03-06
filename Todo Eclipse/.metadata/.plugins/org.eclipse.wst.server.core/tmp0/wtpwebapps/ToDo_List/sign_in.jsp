<!--

sign_in.jsp

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
	<script src="scripts/sign_in.js"></script>
</head>
<body>
	<div class="main-div">
		<!--   con = Container  for items in the form-->
		<div class="con">
			<!--     Start  header Content  -->
			<header class="head-form">
				<h2>SIGN IN</h2>
				<!--     A welcome message or an explanation of the login form -->
				<br>
				<p><b>Sign in here using your Email and Password</b></p>
			</header>
			<br>
			<div class="field-set">
				<html:form action="signingin" method="post">
				
					<!--user name -->
					<html:errors property="email_e"/><br>
					<span class="input-item"><i class="fa fa-user-circle"></i></span>
					<html:text styleClass="form-input" property="email" styleId="email"/><br>
					
					<!--Password -->
					<html:errors property="password_e"/><br>
					<span class="input-item"><i class="fa fa-key"></i></span>
					<html:password styleClass="form-input" property="password" styleId="pwd"/>
					
					<br><br><br>
					<html:submit styleClass="log-in button" value="Sign In"/>
				</html:form>    
				<br><br>
				<!--   other buttons -->
				<div class="other">
					<!--      Forgot Password button-->
					<button class="button submits frgt-pass" onclick="frogotPwd()">Forgot Password</button>
					<!--     Sign Up button -->
					<button class="button submits sign-up" onclick="create_account()">Sign Up 
					<!--         Sign Up font icon -->
					<i class="fa fa-user-plus" aria-hidden="true"></i>
					</button>
					<!--      End Other the Division -->
				</div> 
			</div>
		<!--   End Container  -->
		</div>
	<!-- End Form -->
	</div>
</body>
</html>