$(function() {
	init();
  
	var actionContainer = $(".actionmenu");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
	  
	  if (item.cabeca == true) {
		$('.cabeca').css('opacity', '1');   
		$('.cabeca').css('background-image', 'url(img/cabeca2.png)');
		$('.situacao').css('background-image', 'url(img/situacao.png)');  
	  }

	  if (item.perna == true) {
		$('.perbra').css('opacity', '1');   
		$('.perbra').css('background-image', 'url(img/permao2.png)');
		$('.situacao').css('background-image', 'url(img/situacao2.png)');
	  }

	  if (item.pe == true) {
		$('.pemao').css('opacity', '1');   
		$('.pemao').css('background-image', 'url(img/mape2.png)');
		$('.situacao').css('background-image', 'url(img/situacao3.png)');
	  }

	  if (item.torax == true) {
		$('.coluna').css('opacity', '1');   
		$('.coluna').css('background-image', 'url(img/coluna2.png)');
		$('.situacao').css('background-image', 'url(img/situacao.png)');
	  }

	  if (item.cab == 1) {
		$('.cabeca').css('opacity', '0.9');   
		$('.cabeca').css('background-image', 'url(img/cabeca.png)'); 
	  }

	  if (item.per == 1) {
		$('.perbra').css('opacity', '0.9');   
		$('.perbra').css('background-image', 'url(img/permao.png)'); 
	  }

	  if (item.mao == 1) {
		$('.pemao').css('opacity', '0.9');   
		$('.pemao').css('background-image', 'url(img/mape.png)'); 
	  }

	  if (item.col == 1) {
		$('.coluna').css('opacity', '0.9');   
		$('.coluna').css('background-image', 'url(img/coluna.png)'); 
	  }	

	  if (item.sit == 1) {
		$('.situacao').css('opacity', '0.9');   
		$('.situacao').css('background-image', 'url(img/situacao4.png)'); 
	  }	

  
	  if (item.showmenu) {
		ResetMenu();
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		actionContainer.fadeIn();
	  }
  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }
	});
  
	document.onkeyup = function(data) {
	  if (data.which == 27) {
		if (actionContainer.is(":visible")) {
		  sendData("ButtonClick", "fechar");
		}
	  }
	};
  });
  
  function ResetMenu() {
	$("div").each(function(i, obj) {
	  var element = $(this);
  
	  if (element.attr("data-parent")) {
		element.hide();
	  } {
		element.show();
	  }
	});
  }
  
  function init() {
	$(".button").each(function(i, obj) {
	  if ($(this).attr("data-action")) {
		$(this).click(function() {
		  var data = $(this).data("action");
		  sendData("ButtonClick", data);
		});
	  }
  
	  if ($(this).attr("data-sub")) {
		var menu = $(this).data("sub");
		var element = $("#" + menu);
  
		$(this).click(function() {
		  element.show();
		  $("#mainmenu").hide();
		});
  
		$(".subtop button, .back").click(function() {
		  element.hide();
		  $("#mainmenu").show();
		});
	  }
	});
  }
  
  function sendData(name, data) {
	$.post("http://medical_system/" + name, JSON.stringify(data), function(
	  datab
	) {
	  if (datab != "ok") {
		console.log(datab);
	  }
	});
  }
  
  $('.category_item').click(function() {
	let pegArma = $(this).attr('category');
	$('.item-item').css('transform', 'scale(0)');
  
	function hideArma() {
		$('.item-item').hide();
	}
	setTimeout(hideArma, 100);
  
	function showArma() {
		$('.item-item[category="' + pegArma + '"]').show();
		$('.item-item[category="' + pegArma + '"]').css('transform', 'scale(1)');
	}
	setTimeout(showArma, 100);
  });
  
  $('.category_item[category="all"]').click(function() {
	function showAll() {
		$('.item-item').show();
		$('.item-item').css('transform', 'scale(1)');
	}
	setTimeout(showAll, 100);
  });


  