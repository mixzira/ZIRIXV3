let disabled = false;
let disabledFunction = null;

function Interval(time){
	var timer = false
	this.start = function(){
		if (this.isRunning()){
			clearInterval(timer)
			timer = false
		}

		timer = setInterval(function(){
			disabled = false
		},time)
	}

	this.stop = function(){
		clearInterval(timer)
		timer = false
	}

	this.isRunning = function(){
		return timer !== false
	}
}

const disableInventory = ms => {
	disabled = true

	if (disabledFunction === null){
		disabledFunction = new Interval(ms)
		disabledFunction.start()
	} else {
		if (disabledFunction.isRunning()){
			disabledFunction.stop()
		}
		disabledFunction.start()
	}
}

$(document).ready(function(){
	let actionChest = $("#actionmenu");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				updateChest();
				actionChest.fadeIn(500);
			break;

			case "hideMenu":
				actionChest.fadeOut(500);
			break;

			case "updateChest":
				updateChest();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_inspect/chestClose");
		}
	};
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
			itemData = { key: $(this).data('item-key') };

			if (itemData.key === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.nuinventory-item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key') };

			if (itemData.key === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('#inventory-items').droppable({
		hoverClass: 'hoverControl',
		accept: '.nuinventory-item',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			$.post("http://vrp_inspect/takeItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})
	for (let i = 0; i < data.slots; i++) {
		$("#inventory-items").append(`
			<div class="slot">
			</div>
		`)
	}

	$('#nuinventory-items').droppable({
		hoverClass: 'hoverControl',
		accept: '.item',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			$.post("http://vrp_inspect/storeItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})
	for (let i = 0; i < data.slots; i++) {
		$("#nuinventory-items").append(`
			<div class="slot">
			</div>
		`)
	}

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

const updateChest = () => {
	$.post("http://vrp_inspect/requestChest",JSON.stringify({}),(data) => {
		const nameList = data.inventory.sort((a,b) => (a.name > b.name) ? 1: -1);
		const nameList2 = data.nuinventory.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#inventory-items').html(`
			${nameList.map((item) => (`
				<div class="slot">
					<div class="item" data-item-key="${item.key}" data-vehname-key="${item.vehname}">
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
		$('#nuinventory-items').html(`
			${nameList2.map((item) => (`
				<div class="slot">
					<div class="nuinventory-item" data-item-key="${item.key}" data-vehname-key="${item.vehname}">
						<div id="item-icon"><img src='http://${data.ip}/images/vrp_itens/${item.index}.png'></div>
						<div id="item-weight">${(item.peso*item.amount).toFixed(2)}Kg</div>
						<div id="item-amount">${formatarNumero(item.amount)}x</div>
						<div id="item-name">${item.name}</div>
					</div>
				</div>
			`)).join('')}
		`);
		for (let i = 0; i < data.nuslots; i++) {
			$("#nuinventory-items").append(`
				<div class="slot">
				</div>
			`)
		}
		$('#inventory-bottom').html(`
			<input id="amount" class="qtd" maxlength="9" spellcheck="false" value="" placeholder="QUANTIDADE">
			<div class="inventory-amount-bar"><span id="amount-bar" style="width: ${(data.weight*100/data.maxweight).toFixed(2)}%;"></span></div>
			<div class="inventory-amount-text"><b>${(data.weight).toFixed(2)}</b>Kg de <b>${(data.maxweight).toFixed(2)}</b>Kg</div>
		`);
		$('#nuinventory-bottom').html(`
			<div class="nuinventory-amount-bar"><span id="amount-bar" style="width: ${(data.nuweight*100/data.numaxweight).toFixed(2)}%;"></span></div>
			<div class="nuinventory-amount-text"><b>${(data.nuweight).toFixed(2)}</b>Kg de <b>${(data.numaxweight).toFixed(2)}</b>Kg</div>
		`);
		updateDrag();
	});
}