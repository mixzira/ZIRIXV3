$(document).ready(function(){
	let actionContainer = $("#actionmenu");
	let actionButton = $("#actionbutton");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				actionButton.fadeIn(1000);
				actionContainer.fadeIn(1000);
			break;

			case "hideMenu":
				actionButton.fadeOut(1000);
				actionContainer.fadeOut(1000);
			break;

			case 'updateCarros':
				updateCarros();
			break;

			case 'updateMotos':
				updateMotos();
			break;

			case 'updateImport':
				updateImport();
			break;

			case 'updatePossuidos':
				updatePossuidos();
			break;
		}
	});

	$("#inicio").load("./inicio.html");

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_dealership/dealerClose",JSON.stringify({}),function(datab){});
		}
	};
});

$('#actionbutton').click(function(e){
	$.post("http://vrp_dealership/dealerClose",JSON.stringify({}),function(datab){});
});

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

const carregarMenu = (name) => {
	return new Promise((resolve) => {
		$("#inicio").load(name+".html",function(){
			resolve();
		});
	});
}

const updateCarros = () => {
	$.post("http://vrp_dealership/requestCarros",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			<div class="comprar">COMPRAR</div>
			<div class="obs">Para efetuar uma <b>compra</b> selecione um modelo abaixo e clique em <b>comprar</b>, o sistema vai efetuar as checagens necessárias e se você possuir o valor do veículo ele compra automaticamente.</div>
			<div class="title">CARROS</div>
			${nameList.map((item) => (`
				<div class="model" data-name-key="${item.k}">
					<div class="imagem-carro"><img src="http://192.99.251.232:3555/images/vrp_vehicles/${item.nome}.png"/></div>
					<div class="id">${i = i + 1}</div>
					<div class="name">${item.nome}</div>
					<div class="valor">$${formatarNumero(item.price)}</div>
					<div class="malas">Porta malas: ${item.chest}</div>
					<div class="estoque">Disponível: ${item.stock}</div>
				</div>
			`)).join('')}
		`);
	});
}

const updateMotos = () => {
	$.post("http://vrp_dealership/requestMotos",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			<div class="comprar">COMPRAR</div>
			<div class="obs">Para efetuar uma <b>compra</b> selecione um modelo abaixo e clique em <b>comprar</b>, o sistema vai efetuar as checagens necessárias e se você possuir o valor do veículo ele compra automaticamente.</div>
			<div class="title">MOTOS</div>
			${nameList.map((item) => (`
				<div class="model" data-name-key="${item.k}">
					<div class="imagem-carro"><img src="http://192.99.251.232:3555/images/vrp_vehicles/${item.nome}.png"/></div>
					<div class="id">${i = i + 1}</div>
					<div class="name">${item.nome}</div>
					<div class="valor">$${formatarNumero(item.price)}</div>
					<div class="malas">Porta malas: ${item.chest}</div>
					<div class="estoque">Disponível: ${item.stock}</div>
				</div>
			`)).join('')}
		`);
	});
}

const updateImport = () => {
	$.post("http://vrp_dealership/requestImport",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			<div class="comprar">COMPRAR</div>
			<div class="obs">Para efetuar uma <b>compra</b> selecione um modelo abaixo e clique em <b>comprar</b>, o sistema vai efetuar as checagens necessárias e se você possuir o valor do veículo ele compra automaticamente.</div>
			<div class="title">IMPORTADOS</div>
			${nameList.map((item) => (`
				<div class="model" data-name-key="${item.k}">
					<div class="imagem-carro"><img src="http://192.99.251.232:3555/images/vrp_vehicles/${item.k}.png"/></div>
					<div class="id">${i = i + 1}</div>
					<div class="name">${item.nome}</div>
					<div class="valor">$${formatarNumero(item.price)}</div>
					<div class="malas">Porta malas: ${item.chest}</div>
					<div class="estoque">Disponível: ${item.stock}</div>
				</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".model",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.model').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on("click",".comprar",function(){
	let $el = $('.model.active');
	if($el){
		$.post("http://vrp_dealership/buyDealer",JSON.stringify({
			name: $el.attr('data-name-key')
		}));
	}
});