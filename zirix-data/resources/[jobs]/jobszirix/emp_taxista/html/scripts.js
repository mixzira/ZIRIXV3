
function addGaps(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
  }
  return x1 + x2;
}
function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
  }
  return x1 + x2;
}

$(document).ready(function(){
  // Partial Functions
  function closeMain() {

    $(".full-screen").css("display", "none");
    $(".body").css("display", "none");
  }
  function openMain() {
    $(".full-screen").css("display", "flex");
    $(".body").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
  }
  function openContainer() {
    $(".taxi-container").css("display", "block");
  }
  function closeContainer() {
    $(".taxi-container").css("display", "none");
  }
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Update HUD Balance
    if(item.updateBalance == true) {
      $('.currentfare').html('$'+(event.data.balance));
      $('.currentmiles').html(event.data.player);
    }
    if(item.meterActive == true){
      $('#hired').addClass( "active" ).removeClass( "notactive" );
      $('#timeoff').removeClass( "active" ).addClass( "notactive" );
    }
    if(item.meterActive == false){
      $('#hired').removeClass( "active" ).addClass( "notactive" );;
      $('#timeoff').addClass( "active" ).removeClass( "notactive" );
    }
    // Open & Close main window
    if(item.openMeter == true) {
      openMain();
    }
    if(item.openMeter == false) {
      closeMain();
    }
    // Open sub-windows / partials
  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://emp_taxista/close', JSON.stringify({}));
    }
  };
});
