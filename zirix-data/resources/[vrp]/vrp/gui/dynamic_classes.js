var dynamic_classes = {}

function defineDynamicClass(classname,callback){
	dynamic_classes[classname] = callback;
}

var handle_inserted_element = function(el){
	if(el.classList){
		for(var i = 0; i < el.classList.length; i++){
			var cb = dynamic_classes[el.classList[i]];
			if(cb)
				cb(el);
		}
	}

	var children = el.childNodes;
	if(children){
		for(var i = 0; i < children.length; i++)
			handle_inserted_element(children[i]);
	}
}

var observer = new MutationObserver(function(mutations){
	mutations.forEach(function(mutation){
		for (var i = 0; i < mutation.addedNodes.length; i++){
			var el = mutation.addedNodes[i];
			handle_inserted_element(el);
		}
	});
});

window.addEventListener("load",function(){
	observer.observe(document.body,{ childList: true, subtree: true });
});