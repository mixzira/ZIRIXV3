let disabled = false;
let disabledFunction = null;

function Interval(time) {
	var timer = false
	this.start = function() {
		if (this.isRunning()) {
			clearInterval(timer)
			timer = false
		}

		timer = setInterval(function() {
			disabled = false
		}, time)
	}
	this.stop = function() {
		clearInterval(timer)
		timer = false
	}
	this.isRunning = function() {
		return timer !== false
	}
}

const disableInventory = ms => {
	disabled = true

	if (disabledFunction === null) {
		disabledFunction = new Interval(ms)
		disabledFunction.start()
	} else {
		if (disabledFunction.isRunning()) {
			disabledFunction.stop()
		}

		disabledFunction.start()
	}
}

$(document).ready(function(){
	let actionShop = $("#actionmenu");
	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				$(`#${item.type}`).css('display', 'block');
				$(`#${item.type}`).css('position', 'absolute');
				$(`#${item.type}`).css('width', '365px');
				$(`#${item.type}`).css('height', '350px');
				$(`#${item.type}`).css('right', '0px');
				$(`#${item.type}`).css('margin-top', '40px');
				$(`#${item.type}`).css('float', 'left');
				$(`#${item.type}`).css('overflow', 'auto');
				updateShop();
				actionShop.fadeIn(500);
			break;

			case "hideMenu":
				actionShop.fadeOut(500);
				$(`#${item.type}`).css('display', 'none');
			break;

			case "updateShop":
				updateShop();
			break;
		}
	});
	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_shops/shopClose");
		}
	};
});

const updateDrag = () => {
	$('.shop-item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			if (disabled) return false;

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

	$('.item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			if (disabled) return false;

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
		accept: '.shop-item',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			disableInventory(500);

			$.post("http://vrp_shops/buyItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})

	$('.shop').droppable({
		hoverClass: 'hoverControl',
		accept: '.item',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			disableInventory(500);

			$.post("http://vrp_shops/sellItem", JSON.stringify({
				item: itemData.key,
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

const updateShop = () => {
	$.post("http://vrp_shops/requestShops",JSON.stringify({}),(data) => {
		const inventoryItems = data.inventory.sort((a,b) => (a.name > b.name) ? 1: -1);
		const shopItems = data.itemsshop.sort((a,b) => (a.name > b.name) ? 1: -1);

		$('#inventory-items').html(`
			${inventoryItems.map((item) => (`
				<div class="fake-slot">
					<div class="slot">
						<div class="item" data-item-key="${item.key}">
							<div id="item-icon"><img src='http://${data.imageService}/vrp_itens/${item.index}.png'></div>
							<div id="item-weight">${(item.peso*item.amount).toFixed(2)}Kg</div>
							<div id="item-amount">${formatarNumero(item.amount)}x</div>
							<div id="item-name">${item.name}</div>
						</div>
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
		for (let i = 0; i < data.fslots; i++) {
			$("#inventory-items").append(`
				<div class="fake-slot">
				</div>
			`)
		}
		$('.shop').html(`
			${shopItems.map((item) => (`
				<div class="fake-slot">
					<div id="${data.shopName}">
						<div class="shop-item" data-item-key="${item.itemBody}">
							<div id="item-icon"><img src='http://${data.imageService}/vrp_itens/${item.itemIndex}.png'></div>
							<div id="item-weight">$${item.itemPrice}</div>
							<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
							<div id="item-name">${item.itemName}</div>
						</div>
					</div>
				</div>
			`)).join('')}
		`);
		for (let i = 0; i < data.fshopslots; i++) {
			$(".shop").append(`
				<div class="fake-slot">
				</div>
			`)
		}
		$('#inventory-bottom').html(`
			<input id="amount" class="qtd" maxlength="9" spellcheck="false" value="" placeholder="QUANTIDADE">
			<div class="inventory-amount-bar"><span id="amount-bar" style="width: ${(data.weight*100/data.maxweight).toFixed(2)}%;"></span></div>
			<div class="inventory-amount-text"><b>${(data.weight).toFixed(2)}</b>Kg de <b>${(data.maxweight).toFixed(2)}</b>Kg</div>
		`);

		updateDrag();
	});
}