# FileBrowser

This is a simple Nodejs program written in Haxe, to serve static files on a server.
Dependencies:
 - nodejs
 - npm

### Build from Haxe source
You will need [`Haxe`](http://haxe.org/), and the haxelib libraries [`hxnodejs`](https://github.com/HaxeFoundation/hxnodejs) and [`hxexpress`](https://github.com/abedev/hxexpress)
To compile the `.hx` source code to `.js`, run `haxe build.hxml`.

### Configuration
The `config.js` file contains the necessary differences in settings between development and production.
Possible configuration options are:

```
 watchPath : Path to the folder that will be tracked for file changes
 servePath : Path of the public file directory of the server
 port      : The port number that the app will listen on.
 (env      : just keep this)
```

### Start server
Install [express](http://expressjs.com/), a nodejs dependency, using `npm install`.
A simple `npm start` (which defaults to the --development configuration) or `npm start --production` will start the Nodejs app.

#### How to setup my server on nginx
What you want to do: tell your web server to proxy incoming traffic to the running nodejs app.

I use a nginx web server, so my nginx config settings look something like this:
```
...
# I want to show my file browser at mysite.com/
location / {
    proxy-pass http://localhost:2999; # 2999 is the default port number of the nodejs server.
}

location /filebrowser {
    root /path/to/the/filebrowser/directory; # allow access to css files;
}

location /public {
    root /path/to/public/files;
    try_files $uri $uri/ =404; # serve public files/directories. If neither are possible, show a 404 error
}
...
```