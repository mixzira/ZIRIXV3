$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"'>"+event.data.mensagem+"</div>"
		$(html).fadeIn(2000).appendTo("#notifications").delay(event.data.time).fadeOut(2000);
	})
});