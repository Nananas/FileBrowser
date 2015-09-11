(function (console) { "use strict";
var Client = function() {
};
Client.main = function() {
	var c = new Client();
};
Client.prototype = {
	clicked: function(what) {
	}
};
Client.main();
})(typeof console != "undefined" ? console : {log:function(){}});
