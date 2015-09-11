var development = {
	watchPath: "./test",
	servePath: ".",
	env : "development"
};

var production = {
	watchPath: "../html/public",
	servePath: "./public",
	env : "production"
};

exports.Config = global.process.env.NODE_ENV === 'production' ? production : development;