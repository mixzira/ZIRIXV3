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

				$(`#inventory-title`).css('display', 'block');
				$(`#shop-title`).css('display', 'block');
				$(`#inventory-items`).css('display', 'block');
				$(`#inventory-bottom`).css('display', 'block');
				$(`.shop`).css('display', 'block');

				updateShop();
				actionShop.fadeIn(500);
			break;

			case "hideMenu":
				$(`#${item.type}`).css('display', 'none');
				$(`#shop-bottom`).css('display', 'none');
				$(`#options`).css('display', 'none');
				$(`#buttom-options`).css('display', 'none');

				$(`#title-options`).css('display', 'none');
				$(`#options`).css('display', 'none');
				$(`#options-bottom`).css('display', 'none');
				actionShop.fadeOut(500);
			break;

			case "updateShop":
				updateShop();
			break;

			case 'ownerOn':
				$(`#shop-bottom`).css('display', 'block');
				$(`#buttom-options`).css('display', 'block');
			break;

			case 'optionsOn':
				$(`#${item.type}`).css('display', 'none');

				$(`#inventory-title`).css('display', 'none');
				$(`#shop-title`).css('display', 'none');
				$(`#inventory-items`).css('display', 'none');
				$(`#inventory-bottom`).css('display', 'none');
				$(`.shop`).css('display', 'none');

				$(`#shop-bottom`).css('display', 'none');
				$(`#buttom-options`).css('display', 'none');

				$(`#title-options`).css('display', 'block');
				$(`#options`).css('display', 'block');
				$(`#options-bottom`).css('display', 'block');
			break;

			case 'optionsOff':
				$(`#${item.type}`).css('display', 'block');

				$(`#inventory-title`).css('display', 'block');
				$(`#shop-title`).css('display', 'block');
				$(`#inventory-items`).css('display', 'block');
				$(`#inventory-bottom`).css('display', 'block');
				$(`.shop`).css('display', 'block');

				$(`#shop-bottom`).css('display', 'block');
				$(`#buttom-options`).css('display', 'block');

				$(`#title-options`).css('display', 'none');
				$(`#options`).css('display', 'none');
				$(`#options-bottom`).css('display', 'none');
			break;
		}
	});
	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_advanced_shops/shopClose");
		}
	};

	$("#buttom-options").each(function(i,obj){
		$(this).click(function(){
			$.post("http://vrp_advanced_shops/optionsOn");
		})
	});
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
			$.post("http://vrp_advanced_shops/buyItem", JSON.stringify({
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
			$.post("http://vrp_advanced_shops/sellItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amount").val())
			}))
			document.getElementById("amount").value = "";
		}
	})

	$('#buttom-options').droppable({
		hoverClass: 'hoverControl',
		accept: '.shop-item',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key') };
			if (itemData.key === undefined) return;
			disableInventory(500);
			$.post("http://vrp_advanced_shops/upgradePrice", JSON.stringify({
				item: itemData.key
			}))
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
	$.post("http://vrp_advanced_shops/requestShops",JSON.stringify({}),(data) => {
		const inventoryItems = data.inventory.sort((a,b) => (a.name > b.name) ? 1: -1);
		const shopItems = data.shop.sort((a,b) => (a.name > b.name) ? 1: -1);
		const optionItems = data.options.sort((a,b) => (a.name > b.name) ? 1: -1);

		$('#inventory-items').html(`
			${inventoryItems.map((item) => (`
				<div class="fake-slot">
					<div class="slot">
						<div class="item" data-item-key="${item.key}">
							<div id="item-icon"><img src='http://${data.ip}/image-streaming/Interno/vrp_itens/${item.index}.png'></div>
							<div id="item-weight">${(item.weight*item.amount).toFixed(2)}Kg</div>
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
					<div id="${data.sname}">
						<div class="shop-item" data-item-key="${item.body}">
							<div id="item-icon"><img src='http://${data.ip}/image-streaming/Interno/vrp_itens/${item.index}.png'></div>
							<div id="item-weight">$${item.price}</div>
							<div id="item-amount">${formatarNumero(item.stock)}x</div>
							<div id="item-name">${item.name}</div>
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
		$('#shop-bottom').html(`
			<div class="shop-amount-bar"><span id="amount-bar" style="width: ${(data.vault*100/data.maxvault).toFixed(2)}%;"></span></div>
			<div class="shop-amount-text"><b>$${(data.vault).toFixed(2)}</b> de <b>$${(data.maxvault).toFixed(2)}</b></div>
		`);
		$('#options').html(`
			${optionItems.map((item) => (`
				<div class="option-item">
					<div id="oitem-icon"><img src='http://${data.ip}/image-streaming/Interno/vrp_itens/${item.body}.png'></div>
					<div id="oitem-name">${item.name}</div>
					<div id="oitem-price">$${item.price.toLocaleString('pt-BR')}</div>
					<div id="oitem-description">${item.description}</div>
					<div id="oitem-upgrade" data-item-key="${item.body}" data-item-stock="${item.stock}" data-item-security="${item.security}">ADQUIRIR</div>
				</div>
			`)).join('')}
		`);
		$('#options-bottom').html(`
			<div id="back-options">VOLTAR</div>
			<div id="stock-options">Estoque máximo: ${data.maxstock}</div>
			<div id="security-options">Nível de segurança: ${data.security}</div>
		`);
		updateDrag();
	});
}

$(document).on('click','#oitem-upgrade',function(){
	data = { key: $(this).data('item-key') };
	if (data.key === undefined) return;
	stock = { key: $(this).data('item-stock') };
	security = { key: $(this).data('item-security') };
	$.post('http://vrp_advanced_shops/upgrade', JSON.stringify({
		item: data.key,
		stock: stock.key,
		security: security.key
	}))
})

$(document).on('click','#back-options',function(){
	$.post('http://vrp_advanced_shops/optionsOff', JSON.stringify({}))
})