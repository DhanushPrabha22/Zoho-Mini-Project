$(function() {
    $("#email").attr("placeholder", "Regsitered Email");
    $("#pwd").attr("placeholder", "New Password");
    $("#sec").attr("placeholder", "Security Answer");
});

function cancel(){
	document.location.href='/ToDo_List/sign_in.jsp';
}