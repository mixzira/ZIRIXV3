$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = ""

		if (event.data.mode == 'sucesso') {
			html = "<div id='showitem'><img src='"+event.data.imageService+"/"+event.data.item+".png'></img><b><p><sucesso></sucesso> "+event.data.mensagem+"</p></b><div class='quantidade'><p>"+event.data.quantidade+"x</p></div><div class='peso'><p>"+event.data.peso+"Kg</p></div></div>"
		}

		if (event.data.mode == 'negado') {
			html = "<div id='showitem'><img src='"+event.data.imageService+"/"+event.data.item+".png'></img><b><p><negado></negado> "+event.data.mensagem+"</p></b><div class='quantidade'><p>"+event.data.quantidade+"x</p></div><div class='peso'><p>"+event.data.peso+"Kg</p></div></div>"
		}

		if (event.data.mode == 'usar') {
			html = "<div id='showitem'><img src='"+event.data.imageService+"/"+event.data.item+".png'></img><b><p><negado></negado> "+event.data.mensagem+"</p></b></div>"
		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500);
	})
});