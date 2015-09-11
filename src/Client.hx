import js.html.HTMLDocument;
import js.html.LinkElement;

class Client {
	var DOM:HTMLDocument;

	static function main() {
		var c = new Client();
	}

	public function new() {
		DOM = js.Browser.document;

		js.Browser.window.onload = init;

		trace("Starting client");
	}

	function init() {
		var icons = DOM.getElementsByClassName("icon");
		trace("init");


		for (i in 0 ... icons.length) {
			icons[i].onclick = function() {
				clicked(icons[i].childNodes.item(0).textContent);
			}
		}
	}

	public function clicked(what:String) {
		// var http = new haxe.Http("storage.thomasdendale.com/event");
		var http = new haxe.Http("http://localhost:4000");
		http.async = true;
		http.onError = function(msg){
			trace(msg);
		}

		http.request();
	}
}