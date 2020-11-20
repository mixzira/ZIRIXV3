let roupaID = null;
let dataPart = null;
let change = {}

$(document).ready(function() {
    document.onkeydown = function(data) {
        if (data.keyCode == 27) {
            $('footer').html('');
            $(".loja-de-roupa").fadeOut();
            $('#total').html('0'); 
            change = {};
            $.post('http://vrp_skinshop/reset', JSON.stringify({}))
            $.post('http://ph-hud/fechar', JSON.stringify({ id: false }))
        }
    }

    document.onkeyup = function(data) {
        if (data.which == 174) {
            $.post('http://vrp_skinshop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "menos" }));
        }
    }

    document.onkeyup = function(data) {
        if (data.which == 175) {
            $.post('http://vrp_skinshop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "mais" }));
        }
    }

    $("#leftHeading").click(function() {
        $.post('http://vrp_skinshop/leftHeading', JSON.stringify({ value: 10 }));
    })

    $("#handsUp").click(function() {
        $.post('http://vrp_skinshop/handsUp', JSON.stringify({}));
    })

    $("#rightHeading").click(function() {
        $.post('http://vrp_skinshop/rightHeading', JSON.stringify({ value: 10 }));
    })

    $("#payament").click(function() {
        $(".loja-de-roupa").fadeOut()
        $.post('http://ph-hud/fechar', JSON.stringify({ id: false }));
        $.post('http://vrp_skinshop/payament', JSON.stringify({ price: $('#total').text() }));
        $('#total').html('0');
        change = {};
    })

    window.addEventListener('message', function(event) {
        let item = event.data;

        if (item.action == 'setPrice') {
            if (item.typeaction == "add") {
                $('#total').html(item.price)
            }
            if (item.typeaction == "remove") {
                $('#total').html(item.price)
            }
        }

        if (item.openLojaRoupa) {
            change = {};
            $(".loja-de-roupa").fadeIn()
            $.post('http://ph-hud/fechar', JSON.stringify({ id: true }))
            dataPart = item.category
            for (var i = 0; i <= item.drawa; i++) {
                $("footer").append(`
                    <div class="item-clothe" data-id="${i}" onclick="select(this)">
                        <div class="img-clothe" style="background-image: url('http://192.99.251.232:3555/images/vrp_clothes/${item.category}/${item.sexo}/${item.prefix}(${i}).jpg')">  
                            <div class="overlay">
                                <span>${i}</span>
                            </div>
                        </div>
                    </div>
                `);
            };
        }
        if (item.changeCategory) {
            dataPart = item.category
            $('footer').html('')
            for (var i = 0; i <= item.drawa; i++) {
                $("footer").append(`
                    <div class="item-clothe" data-id="${i}" onclick="select(this)">
                        <div class="img-clothe" style="background-image: url('http://192.99.251.232:3555/images/vrp_clothes/${item.category}/${item.sexo}/${item.prefix}(${i}).jpg')">  
                            <div class="overlay">
                                <span>${i}</span>
                            </div>
                        </div>
                    </div>
                `);
            };
        }
    })
});

function update_valor() {
    const formatter = new Intl.NumberFormat('pt-BR', { minimumFractionDigits: 2 })
    let total = 0
    for (let key in change) { if (!change[key] == 0) { total += 40 } }
    $('#total').html(formatter.format(total))
}


function selectPart(element) {
    let dataPart = element.dataset.idpart
    $('header h1').html(dataPart)
    $('.submenu-item').find('img').css('filter', 'brightness(100%)')
    $('.submenu-item').removeClass('subActive')
    $(element).addClass('subActive')
    $(element).find('img').css('filter', 'brightness(0%)')
    $.post('http://vrp_skinshop/changePart', JSON.stringify({ part: dataPart }))
}

function select(element) {
    roupaID = element.dataset.id;
    $("footer div").css("border", "0");
    $('footer div').find('.overlay').css("background-color", "rgba(0, 0, 0, 0.507)");
    $(element).css("border", "1px solid #85a016");
    $(element).find('.overlay').css("background-color", "#85a016");
    $.post('http://vrp_skinshop/changeCustom', JSON.stringify({ type: dataPart, id: roupaID }));
}

$(".fa-angle-right").click(function() {
    $.post('http://vrp_skinshop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "mais" }));
})

$(".fa-angle-left").click(function() {
    $.post('http://vrp_skinshop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "menos" }));
})


