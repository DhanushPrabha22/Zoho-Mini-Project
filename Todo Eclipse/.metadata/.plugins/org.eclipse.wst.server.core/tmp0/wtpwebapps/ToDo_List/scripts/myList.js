function openNav() {
  document.getElementById("mySidenav").style.width = "350px";
  document.getElementById("main").style.marginLeft = "350px";
  document.getElementById("emailId").style.marginLeft = "350px";
  document.getElementById("searchPopUpBtn").style.width = "280px";
  document.getElementById("searchPopUpBtn").style.marginLeft = "0";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
  document.getElementById("emailId").style.marginLeft = "15px";
  document.getElementById("searchPopUpBtn").style.width = "400px";
  document.getElementById("searchPopUpBtn").style.marginLeft = "50px";
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
	$('#sortColumn').on('change',function(){
		 	jQuery('#replaceMe').replaceWith(jQuery('#iamReplacement'));
	        if( $(this).val()==="COUNT(category_list)"){
	        $("#catValue").show()
	        }
	        else{
	        $("#catValue").hide()
	        }
	   });
}

function showSearchModal(){
	var searchModal = document.getElementById("searchModal");
	var cancelSearch = document.getElementById("cancelSearchModal");
	searchModal.style.display = "block";
	cancelSearch.onclick = function() {
		searchModal.style.display = "none";
	}
	window.onclick = function(event) {
		if (event.target == searchModal) {
			searchModal.style.display = "none";
		}
	}
}

function showSearchedTask(){
	var input, filter, table, tr, td, i, txtValue;
	input = document.getElementById("searchedTask");
    filter = input.value.toUpperCase();
	table = document.getElementById("searchTable");
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
	  td = tr[i].getElementsByTagName("td")[0];
	  if (td) {
	  txtValue = td.textContent || td.innerText;
	  if (txtValue.toUpperCase().indexOf(filter) > -1) {
	    tr[i].style.display = "";
	  } else {
	     tr[i].style.display = "none";
	    }
	  }       
	}
}

function finalSearchMethod(id){
	var searchModal = document.getElementById("searchModal");
	searchModal.style.display = "none";
	
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