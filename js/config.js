var development = {
	watchPath: "./test",
	servePath: "."
};

var production = {
	watchPath: "../html/public",
	servePath: "./public/"
};

exports.Config = global.process.env.NODE_ENV === 'production' ? production : development;