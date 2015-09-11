import express.Express;
import express.Middleware;
import js.node.Fs;
import haxe.Template;

class LocalEventServer
{
	var app:Express;

	public function new() {

		app = new Express();


untyped __js__("this.app.use(function (req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8888');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Set to true if you need the website to include cookies in the requests sent
    // to the API (e.g. in case you use sessions)
    res.setHeader('Access-Control-Allow-Credentials', true);

    // Pass to next layer of middleware
    next();
});");

		app.get("/", function(req, res) {
			trace(req.headers);
			res.send("");
		});

		app.listen(4000);

		trace("Listening...");
	}

	static function main(){
		var main = new LocalEventServer();
	}
}