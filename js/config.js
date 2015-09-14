var development = {
	watchPath : "./test",
	servePath : ".",
	env       : "development"	// keep!
};

var production = {
	watchPath : "../html/public",
	servePath : "./public",
	env       : "production",
	port      : 2999
};

exports.Config = global.process.env.NODE_ENV === 'production' ? production : development;