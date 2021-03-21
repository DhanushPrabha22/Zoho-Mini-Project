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
	var cancel = document.getElementById("cancelAddTask");
	btn.onclick = function() {
		modal.style.display = "block";
	}
	cancel.onclick = function() {
		  modal.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
}

function deleteTask(taskId, taskName, subFlag, dateFlag, catFlag){
	var deleteModal = document.getElementById("deleteModal");
	var cancel = document.getElementById("cancelDeleteTask");
	deleteModal.style.display = "block";
	cancel.onclick = function() {
		deleteModal.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == deleteModal) {
			deleteModal.style.display = "none";
		}
	}
	
	$(function() {
		$("#taskIdDelete").attr("value", taskId);
		$("#taskNameDelete").attr("value", taskName);
		$("#subFlagDelete").attr("value", subFlag);
		$("#dateFlagDelete").attr("value", dateFlag);
		$("#catFlagDelete").attr("value", catFlag);
	});
}

function updateTask(id){
	
	var cId = id.split(/(\d+)/);
	
	var spanId = "taskNameSpan"+cId[1];
	var spanId2 = "taskIdSpan"+cId[1];
	var taskStatusId = "statusChk"+cId[1];
	var impStatusId = "impStatusShow"+cId[1];
	var flagStatusId = "flagStatusShow"+cId[1];
	var descriptionId = "taskDescriptionSpan"+cId[1];
	var remainderId = "remainderSpan"+cId[1];
	var dueId = "dueSpan"+cId[1];
	var repeatId = "repeat"+cId[1];
	var categoryId = "categorySpan"+cId[1];
	var subTaskId  = "subTaskSpan"+cId[1];
	
	var taskName = document.getElementById(spanId).innerHTML;
	var taskId = document.getElementById(spanId2).innerHTML;
	var taskStatus = document.getElementById(taskStatusId).value;
	var impStatus = document.getElementById(impStatusId).value;
	var flagStatus = document.getElementById(flagStatusId).value;
	var taskDescription = document.getElementById(descriptionId).innerHTML;
	var remainderDate = document.getElementById(remainderId).innerHTML;
	var dueDate = document.getElementById(dueId).innerHTML;
	var repeatStatus = document.getElementById(repeatId).innerHTML;
	var category = document.getElementById(categoryId).innerHTML;
	var subTask = document.getElementById(subTaskId).innerHTML;
	
	taskName = taskName.split(/\s/).join('');
	taskId = taskId.split(/\s/).join('');
	taskDescription = taskDescription.replace(/\s+/g,' ').trim();
	remainderDate = remainderDate.split(/\s/).join('');
	dueDate = dueDate.split(/\s/).join('');
	repeatStatus = repeatStatus.split(/\s/).join('');
	category = category.replace(/\s+/g,' ').trim();
	subTask = subTask.replace(/\s+/g,' ').trim();
	
	$(function() {
	    $("#taskNameF").attr("value", taskName);
	    $("#taskId").attr("value", taskId);
	    if(taskStatus === 'on'){
	    	$("#taskStatus").prop("checked", true);
	    }else if(taskStatus === 'off'){
	    	$("#taskStatus").prop("checked", false);
	    }
	    if(impStatus === 'on'){
	    	$("#impStatus").prop("checked", true);
	    }else if(impStatus === 'off'){
	    	$("#impStatus").prop("checked", false);
	    }
	    if(flagStatus === 'on'){
	    	$("#flagStatus").prop("checked", true);
	    }else if(flagStatus === 'off'){
	    	$("#flagStatus").prop("checked", false);
	    }
	    $("#descriptionF").attr("value", taskDescription);
	    $("#remainder").attr("value", remainderDate);
	    $("#dueDate").attr("value", dueDate);
	    $("#repeat").attr("value", repeatStatus);
	    $("#category").attr("value", category);
	    $("#subTasks").attr("value", subTask);
	});
}

$(function() {
    $("#taskNameF").attr("placeholder", "Task Name");
    $("#descriptionF").attr("placeholder", "Description");
    $("#taskName").attr("placeholder", "Task Name");
    $("#description").attr("placeholder", "Description");
    $("#remainder").attr("placeholder", "Remainder");
    $("#dueDate").attr("placeholder", "Due Date");
    $("#repeat").attr("placeholder", "Repeat");
    $("#subTasks").attr("placeholder", "Sub Tasks");
    $("#category").attr("placeholder", "Category");
});