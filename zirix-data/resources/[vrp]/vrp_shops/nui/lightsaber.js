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
				if (item.type == 'accessories' ) {
					$('#accessories').css('display', 'block');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'ammunation') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'block');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'pub') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'block');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'coffeeshop') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'block');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'convenienceshop') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'block');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'digitalshop') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'block');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'drugshop') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'block');
					$('#toolshop').css('display', 'none');
				}
				if (item.type == 'toolshop') {
					$('#accessories').css('display', 'none');
					$('#ammunation').css('display', 'none');
					$('#pub').css('display', 'none');
					$('#coffeeshop').css('display', 'none');
					$('#convenienceshop').css('display', 'none');
					$('#digitalshop').css('display', 'none');
					$('#drugshop').css('display', 'none');
					$('#toolshop').css('display', 'block');
				}

				updateShop();
				actionShop.fadeIn(500);
			break;

			case "hideMenu":
				actionShop.fadeOut(500);
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
		const accessoriesItems = data.accessories.sort((a,b) => (a.name > b.name) ? 1: -1);
		const ammunationItems = data.ammunation.sort((a,b) => (a.name > b.name) ? 1: -1);
		const pubItems = data.pub.sort((a,b) => (a.name > b.name) ? 1: -1);
		const coffeeshopItems = data.coffeeshop.sort((a,b) => (a.name > b.name) ? 1: -1);
		const convenienceshopItems = data.convenienceshop.sort((a,b) => (a.name > b.name) ? 1: -1);
		const digitalshopItems = data.digitalshop.sort((a,b) => (a.name > b.name) ? 1: -1);
		const drugshopItems = data.drugshop.sort((a,b) => (a.name > b.name) ? 1: -1);
		const toolshopItems = data.toolshop.sort((a,b) => (a.name > b.name) ? 1: -1);

		$('#inventory-items').html(`
			${inventoryItems.map((item) => (`
				<div class="item">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.index}.png'></div>
					<div id="item-weight">${(item.peso*item.amount).toFixed(2)}Kg</div>
					<div id="item-amount">${formatarNumero(item.amount)}x</div>
					<div id="item-name">${item.name}</div>
				</div>
			`)).join('')}
		`);

		$('#accessories').html(`
			${accessoriesItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#ammunation').html(`
			${ammunationItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#pub').html(`
			${pubItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#coffeeshop').html(`
			${coffeeshopItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#convenienceshop').html(`
			${convenienceshopItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#digitalshop').html(`
			${digitalshopItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#drugshop').html(`
			${drugshopItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#toolshop').html(`
			${toolshopItems.map((item) => (`
				<div class="shop-item" data-item-key="${item.itemBody}">
					<div id="item-icon"><img src='http://192.99.251.232:3555/images/vrp_itens/${item.itemIndex}.png'></div>
					<div id="item-weight">$${item.itemPrice}</div>
					<div id="item-amount">${formatarNumero(item.itemAmount)}x</div>
					<div id="item-name">${item.itemName}</div>
				</div>
			`)).join('')}
		`);

		$('#inventory-bottom').html(`
			<input id="amount" class="qtd" maxlength="9" spellcheck="false" value="" placeholder="QUANTIDADE">
			<div class="inventory-amount-bar"><span id="amount-bar" style="width: ${(data.weight*100/data.maxweight).toFixed(2)}%;"></span></div>
			<div class="inventory-amount-text"><b>${(data.weight).toFixed(2)}</b>Kg de <b>${(data.maxweight).toFixed(2)}</b>Kg</div>
		`);

		updateDrag();
	});
}