(function($) {
  $.fn.inputFilter = function(inputFilter) {
    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  };
}(jQuery));

$(document).on('contextmenu', function(event) {
    event.preventDefault();
});

function str_reverse(str) {
  var splitString = str.split("");
  var reverseArray = splitString.reverse();
  var joinArray = reverseArray.join("");
  return joinArray;
}

$(document).ready(function() {
  var actionContainer = $(".inventory-mask, .inventory-content");

  window.addEventListener("message", function(event) {
    var item = event.data;
    switch (item.action) {
      case "showMenu":
        update();
        actionContainer.fadeIn(500);
        break;

      case "hideMenu":
        actionContainer.fadeOut(500);
        break;

      case "update":
        update();
        break;
    }
  });

  document.onkeyup = function(data) {
    if (data.which == 27) {
      $.post("http://vrp_tuning/close", JSON.stringify({}), function(datab) {});
    }
    if (data.which == 8) {
      $.post("http://vrp_tuning/back", JSON.stringify({}), function(datab) {});
    }
  };
});

const formatarNumero = n => {
  var n = n.toString();
  var r = "";
  var x = 0;

  for (var i = n.length; i > 0; i--) {
    r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
    x = x == 2 ? 0 : x + 1;
  }

  return r
    .split("")
    .reverse()
    .join("");
};

var update = () => {

  $.post("http://vrp_tuning/requestData", JSON.stringify({}), data => {
    var nameList = data.objects.sort((a, b) => (a.index > b.index ? 1 : -1));
    $('.inventory-title').html(`
      Tuning
    `);
    $(".row.objects").html(`
    ${nameList
      .map(
        item => `
        <div class="cell" data-item-key="${item.key}" data-item-index="${item.index}">
        <div class="amount-option">
          <div class="row">
            <div class="left">
              <div class="plus"><i class="fas fa-minus"></i></div>
            </div>
            <div class="center"><input type="text" class="amount-value" placeholder="" style="border: 0px; outline: 0px; width: 100%; height: 100%; text-align: center; padding-left: 5px; padding-right: 5px;" /></div>
            <div class="right">
              <div class="minus"><i class="fas fa-plus"></i></div>
            </div>
          </div>
          <div class="row">
            <button class="button" data-event="send"></button>
          </div>
          <div class="row">
            <button class="button cancel" data-event="cancel">Cancelar</button>
          </div>
        </div>
        <div class="row">
          <span class="price">${item.prefix}${item.amount}</span>
        </div>
        <div class="row">
          <div class="image" style="background-image: url('http://191.96.225.72/images/tuning/${item.key}.png')"></div>
        </div>
        <div class="row">
          <div class="name">${item.name}</div>
        </div>
      </div>
    `
      )
      .join("")}
		`);
  });
};

window.Option = false;

$(document).ready(function() {
 
  $(document).on('mousedown', '.objects .cell', function(ev){
    if(ev.which == 1) {
      $(".cell .options").hide();
      $('.amount-option').hide();
      var $el = $(this).closest('.cell');
    
      $.post(
        "http://vrp_tuning/selectObject",
        JSON.stringify({
          item: Number($el.data("item-key")),
          peca: Number($el.data("item-index"))
        })
      );
    }
  });

  function sendData(name, data) {
    $.post("http://vrp_tuning/" + name, JSON.stringify(data), function(
      datab
    ) {
      if (datab != "ok") {
      console.log(datab);
      }
    });
    }

  $(".menuoption").each(function(i, obj) {
    
	  if ($(this).attr("data-action")) {
		$(this).click(function() {
		  var data = $(this).data("action");
		  sendData("buttonClick", data);
		});
	  }
  });
  
});

