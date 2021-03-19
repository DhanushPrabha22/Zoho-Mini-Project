$(function() {
    $("#email").attr("placeholder", "Email");
    $("#pwd").attr("placeholder", "Password");
    $("#sec").attr("placeholder", "Security Answer");
});

function cancel(){
	document.location.href='/ToDo_List/sign_in.jsp';
}