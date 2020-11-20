$(document).ready(function(){
	let actionContainer = $("#estacionamento");

	window.addEventListener('message',function(event){
		let item = event.data;
		switch(item.action){
			case 'showMenu':
				updateGarages();
				actionContainer.fadeIn(700);
			break;

			case 'hideMenu':
				actionContainer.fadeOut(700);
			break;

			case 'updateGarages':
				updateGarages();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			sendData("ButtonClick","exit")
		}
	};
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

const sendData = (name,data) => {
	$.post("http://vrp_garages/"+name,JSON.stringify(data),function(datab){});
}

const updateGarages = () => {
    $.post('http://vrp_garages/myVehicles',JSON.stringify({}),(data) => {
		const nameList = data.vehicles.sort((a,b) => (a.name2 > b.name2) ? 1: -1);

        $('#carros').html(`
            
            ${nameList.map((item) => (`
				<div class="carro" data-carro-name="${item.name}">
                    <div class="imagem-carro"><img src="http://192.99.251.232:3555/images/vrp_vehicles/${item.name}.png"/></div>
                    <div class="nome-carro"><p>${item.name2}</p></div>
                    <div class="status">
                        <div class="status-titulo"><p>STATUS</p></div>
                        <div class="status-motor">
                            <div class="barra-motor"><span id="motor" style="width: ${item.engine}%;"></span></div>
                            <div class="icone-motor"><img src="http://192.99.251.232:3555/images/vrp_vehicles/motor.png"/></div>
                            <div class="texto-motor"><p>${item.engine}%</p></div>
                        </div>
                        <div class="status-chassis">
                            <div class="barra-chassis"><span id="chassis" style="width: ${item.body}%;"></span></div>
                            <div class="icone-chassis"><img src="http://192.99.251.232:3555/images/vrp_vehicles/chassis.png"/></div>
                            <div class="texto-chassis"><p>${item.body}%</p></div>
                        </div>
                        <div class="status-fuel">
                            <div class="barra-fuel"><span id="fuel" style="width: ${item.fuel}%;"></span></div>
                            <div class="icone-fuel"><img src="http://192.99.251.232:3555/images/vrp_vehicles/combustivel.png"/></div>
                            <div class="texto-fuel"><p>${item.fuel}%</p></div>
                        </div>
                    </div>
                    <div class="licenca">
                        <div class="licenca-titulo"><p>LICENÇA</p></div>
                        <div class="licenca-tax">
                            <div class="icone-tax"><img src="http://192.99.251.232:3555/images/vrp_vehicles/tax.png"/></div>
                            <div class="texto-tax"><p>${item.ipva}</p></div>
                        </div>
                        <div class="licenca-valor">
                            <div class="icone-valor"><img src="http://192.99.251.232:3555/images/vrp_vehicles/money.png"/></div>
                            <div class="texto-valor"><p>${item.status}</p></div>
                        </div>
                    </div>
                </div>
			`)).join('')}
		`);
	});
}

$(document).on('click','.carro',function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.carro').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on('click','.retirar',function(){
	let $el = $('.carro.active');
	if($el) {
		$.post('http://vrp_garages/spawnVehicles',JSON.stringify({
			name: $el.attr('data-carro-name')
		}));
	}
})

$(document).on('click','.guardar',function(){
	$.post('http://vrp_garages/deleteVehicles',JSON.stringify({}));
})