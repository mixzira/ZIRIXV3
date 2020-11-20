$(document).ready(function(){
  var $debug = $("#debug");
  var $heal = $("#vida");
  var $boxArmor = $("#colete");
  
  window.addEventListener('message', function(event){
    if ( event.data.display == true ) {
      $('.hud').fadeIn();
      $('body').show();
    }   
    else {
      $('.hud').fadeOut();
    }

    if ( event.data.incar == true ) {
      $("#car").fadeIn(750).css('bottom','39px');
    } 
    else {
      $('#car').css('bottom','-99px');
      $("#car").fadeOut(750);
    }
    if ( event.data.cinto == true ) {
      $('.cintoon').css('display', 'block');    
      $('.cintooff').css('display', 'none'); 
    }   
    else {
      $('.cintooff').css('display', 'block');
      $('.cintoon').css('display', 'none'); 
    }

    if ( event.data.farol == 0 ) {
      $('.farol-icone').css('opacity', '0.4');   
      $('.farol-icone').css('background-image', 'url(imagens/faroloff.png)');   
    }   
     if ( event.data.farol == 1 ) {
      $('.farol-icone').css('opacity', '1');   
      $('.farol-icone').css('background-image', 'url(imagens/farolon.png)');   
    }   
    if ( event.data.farol == 2 ) {
      $('.farol-icone').css('opacity', '1');   
      $('.farol-icone').css('background-image', 'url(imagens/farolalto.png)');   
    }

    $("#km").html(event.data.speed); 

    $boxArmor.css("width", (event.data.armor)+"%");
    $heal.css("width", (event.data.heal)+"%");

    var data = event.data;

    $("#tempo").html(data.hora+':'+data.minuto);
    $("#endereco").html(data.rua+'.');
    $("#fome").css("height", 100 - data.hunger + "%");
    $("#sede").css("height", 100 - data.thirst + "%");
    $("#combustivel").css("width", data.gas + "%");
  });
});