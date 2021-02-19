$(document).ready(function(){
    window.addEventListener("message",function(event){
        var html = "<div class='animation animate__animated'><div class='notification'><p class='text-now animate__animated animate__fadeInRight animate__delay-2s'></p><p class='theme-text animate__animated animate__fadeInLeft animate__delay-2s "+event.data.css+"' >"+event.data.css+"</p><div class='animate__delay-3s animate__animated animate__heartBeat icon "+event.data.css+"'></div><p class='mensage "+event.data.css+"'>" +event.data.mensagem+ "</p></div></div>"
		$(html).appendTo(".container").hide().show().addClass('animate__fadeIn').delay(8000).queue(function(next) {
                    $( this ).removeClass('animate__fadeIn').addClass('animate__fadeOut').delay(1000);
                    next();
                }).delay(500).queue(function( next ) {
                    $( this ).fadeOut(3000).hide().empty();
                })
    });
});