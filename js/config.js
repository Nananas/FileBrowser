var development = {
	watchPath: "./test"
};

var production = {
	watchPath: "../html/public"
};

exports.Config = global.process.env.NODE_ENV === 'production' ? production : development;