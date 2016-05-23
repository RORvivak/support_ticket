
$(document).ready(function() {
	$('.button').on('click',function(){
		if($('#ticket_reply_staff_reply').val()== '')
		{
			alert("Reply can't be blank");
			return false;
		}
		if($('#ticket_reply_customer_reply').val()== '')
		{
			alert("Reply can't be blank");
			return false;
		}
	});	


});