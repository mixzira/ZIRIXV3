$(document).ready(function(){
    window.addEventListener('message',function(event){
        let item = event.data;
        switch(item.action){
            case "showMenu":
				$(`#content`).css('display', 'block');
			break;

			case "hideMenu":
				$(`#content`).css('display', 'none');
			break;
        }
    });

    document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://police_tablet/close");
		}
	};
});