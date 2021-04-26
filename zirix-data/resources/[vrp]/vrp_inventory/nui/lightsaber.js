$(document).ready(function(){
	init();

	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				updateInventory();
				$("#actionmenu").fadeIn(500);
			break;

			case "hideMenu":
				$("#actionmenu").fadeOut(500);
			break;

			case "updateInventory":
				updateInventory();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_inventory/invClose");
		}
	};

	$(document).on('mousedown', '.item', function(ev){
		if(ev.which == 3) {
		  	itemData = { key: $(ev.target ).closest('.item').data('item-key'), type: $(ev.target ).closest('.item').data('item-type') };
			if (itemData.key === undefined || itemData.type === undefined) return;
				$.post("http://vrp_inventory/useItem", JSON.stringify({
					item: itemData.key,
					type: itemData.type,
					amount: Number($("#amount").val())
				}))
			document.getElementById("amount").value = "";
		  	}
	  	});

	$(".use").each(function(i,obj){
		$(this).click(function(){
			$.post("http://vrp_inventory/useClick", JSON.stringify({
			
			}))
		})
	});

	$(".close").each(function(i,obj){
		$(this).click(function(){
			$.post("http://vrp_inventory/invClose");
		})
	});

	$(".unequip").each(function(i,obj){
		$(this).click(function(){
			$.post("http://vrp_inventory/unEquip", JSON.stringify({

			}))
		})
	});
});

const updateDrag = () => {
	$('.item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key'), type: $(this).data('item-type') };

			if (itemData.key === undefined || itemData.type === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.use').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key'), type: ui.draggable.data('item-type') };

			if (itemData.key === undefined || itemData.type === undefined) return;

			$.post("http://vrp_inventory/useItem", JSON.stringify({
				item: itemData.key,
				type: itemData.type,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})

	$('.drop').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key'), type: ui.draggable.data('item-type') };

			if (itemData.key === undefined || itemData.type === undefined) return;

			$.post("http://vrp_inventory/dropItem", JSON.stringify({
				item: itemData.key,
				type: itemData.type,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})

	$('.send').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key'), type: ui.draggable.data('item-type') };

			if (itemData.key === undefined || itemData.type === undefined) return;

			$.post("http://vrp_inventory/sendItem", JSON.stringify({
				item: itemData.key,
				type: itemData.type,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})
}

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;
	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}
	return r.split('').reverse().join('');
}

const updateInventory = () => {
	document.getElementById("amount").value = "";
	$.post("http://vrp_inventory/requestInventory",JSON.stringify({}),(data) => {
		const nameList = data.inventario.sort((a,b) => (a.name > b.name) ? 1: -1);

		$('#inventory-items').html(`
			${nameList.map((item) => (`
				<div class="slot">
					<div class="item" data-item-key="${item.key}" data-item-type="${item.type}" data-name-key="${item.name}">
						<div id="item-icon"><img src='http://${data.ip}/images/vrp_itens/${item.index}.png'></div>	
						<div id="item-weight">${(item.peso*item.amount).toFixed(2)}Kg</div>
						<div id="item-amount">${formatarNumero(item.amount)}x</div>
						<div id="item-name">${item.name}</div>
					</div>
				</div>	
			`)).join('')}
		`);
		for (let i = 0; i < data.slots; i++) {
			$("#inventory-items").append(`
				<div class="slot">
				</div>
			`)
		}
        $('#inventory-amount').html(`
            <div class="amount-bar"><span id="amount-bar" style="width: ${(data.peso*100/data.maxpeso).toFixed(2)}%;"></span></div>
            <div class="amount-text"><b>${(data.peso).toFixed(2)}</b>Kg de <b>${(data.maxpeso).toFixed(2)}</b>Kg</div>
		`);
		updateDrag();
	});
}

function init() {
	
}