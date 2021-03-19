function openNav() {
  document.getElementById("mySidenav").style.width = "350px";
  document.getElementById("main").style.marginLeft = "350px";
  document.getElementById("emailId").style.marginLeft = "350px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
  document.getElementById("emailId").style.marginLeft = "15px";
}

window.onload = function(e){ 
	var modal = document.getElementById("myModal");
	var btn = document.getElementById("myBtn");
	var span = document.getElementsByClassName("close")[0];
	btn.onclick = function() {
		modal.style.display = "block";
	}
	span.onclick = function() {
		modal.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
}

$(function() {
    $("#taskName").attr("placeholder", "Task Name");
    $("#description").attr("placeholder", "Description");
    $("#remainder").attr("placeholder", "Remainder (YYYY-MM-DD)");
    $("#dueDate").attr("placeholder", "Due Date (YYYY-MM-DD)");
    $("#repeat").attr("placeholder", "Repeat");
    $("#subTasks").attr("placeholder", "Sub Tasks");
    $("#category").attr("placeholder", "Category");
});