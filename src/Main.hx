import express.Express;
import js.node.Fs;
import haxe.Template;

class Main
{
	var cfg = untyped __js__("require('./config').Config;");

	var app:Express;

	var files:Array<FileNode>;

	var path:String;

	var servePath:String;

	var servedPage:String = "";

	var template:Template;

	var template_path:String = "./html/T_Viewer_blocks.html";

	var title:String = "Public Directory Browser";

	var template_compiled:String = "";

	var template_string:String;

	public function new() {

		path = cfg.watchPath;
		servePath = cfg.servePath;


		template_string = Fs.readFileSync(template_path, {encoding:"UTF-8"});

		runParser();

		Fs.watch(path, function(event, filename) {
			if (event == "rename")
			{
				trace(filename);
				runParser();
			}
		});

		app = new Express();

		var port = cfg.port != null ? cfg.port : 2999;

		// serve static files directly with nginx
		if (cfg.env == "development")
		{
			app.use("/filebrowser", Express.serveStatic('filebrowser'));
		}

		app.get("/", function(req, res) {
			res.send(template_compiled);
		});


		app.listen(port);

		trace("------------------------");
		trace(" Watch path: "+path);
		trace(" Serve path: "+servePath);
		trace("------------------------");
		trace(" Port: "+port);
		trace("------------------------");
	}


	function runParser() {
		trace("RUNNING PARSER");
		var directory = new DirectoryNode(title);

		Fs.readdir(path, function(err, f) {
			for (i in f) {
				var stats:js.node.fs.Stats = Fs.statSync(path + "/" + i);
				if (!stats.isDirectory()) {
					var size = stats.size;
					var node:FileNode = new FileNode(i, servePath + "/" + i, size);
					directory.addFile(node);
				}
			}

			template = new Template(template_string);
			template_compiled = template.execute(directory);
		});

	}


	static function main(){
		var main = new Main();
	}
}

class DirectoryNode {
	public var title:String;
	public var files_list : Array<FileNode>;
	public var files: Iterator<FileNode>;

	public function new(title) {
		this.title = title;

		files_list = new Array<FileNode>();

		files = files_list.iterator();
	}

	public function addFile(f:FileNode) {
		files_list.push(f);
	}

}

class FileNode {
	public var name:String;
	public var path:String;
	public var type:Int;
	public var size:String;

	var _filename_size:Int = 20;

	public function new (name, path, size) {

		var newname = "";
		var rest:String = name;

		while (rest.length > _filename_size) {

			var first = rest.substr(0,_filename_size);
			var newrest = rest.substr(_filename_size);
			newname += first + "<br/>";

			rest = newrest;
		}

		newname += rest;

		this.name = newname;
		this.path = path;
		if (size < 1000)
			this.size = size + " B";
		else if (size < 1000000)
			this.size = Math.round(size/1000) + " KB";
		else
			this.size = Math.round(size/100000) + " MB";


		var end_list:Array<String> = name.split(".");
		var end = end_list[end_list.length - 1];

		switch(end.toLowerCase()) {
			case "zip" , "rar" , "gz" , "7z":
				type = 1;
			case "jpg" , "jpeg" , "gif" , "png" , "bmp":
				type = 2;
			case "pdf":
				type = 3;
			case "flac" , "mp3":
				type = 4;
			case "doc" , "docx":
				type = 5;
			case "ppt" , "pptx":
				type = 6;
			case "xls" , "xlsx":
				type = 7;
			default:
				type = 0;
		}
	}
}