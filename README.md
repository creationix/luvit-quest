# luvit-quest
An interactive workshop that teaches network programming with luvit.

## Tracks

There are two main tracks for adventurers to choose, they are node-style and coro-style.  The noode-style teaches the APIs in luvit 1.x which mirror the APIs in node.js.  The coro-style is a new style that uses coroutines to block on I/O without blocking the thread itself so that the event loop can continue to run.

## Basic Progression

In either style, the progression will be the same, players will learn skills that enable them to earn achievements that contain keys to later quests.

For example, here is a sample level:

Initial Tools:

HTTP Client URL - Used to notify dungeon master that your server is ready to be tested.


```sh
lit install luvit/luvit
```

Modify the following program to reply with a 200 response containing application/json with
"method" and "path" properties.

```lua
-- Load the node-style HTTP library
local http = require('http')
-- Load the JSON encoder
local jsonStringify = require('json').stringify

-- Create an HTTP server node-style.
local server = http.createServer(function (req, res)
  -- req.method --> the HTTP verb of the request
  -- req.path   --> the request path (including query string, but not domain or protocol)

  res:writeHead(404, {['Content-Type'] = 'text/plain'})
  res:finish('Not found\n')

end)

-- Bind to port 8080 and start listening
server:listen(8080)

-- Print a nice message so you know it got this far
print("HTTP Server listening at http://localhost:8080")
```

And then run the server

```sh
luvit server.lua
```

The user will create a local server and run it.  Then in another terminal tab, or a browser, they will ask the dungeon master
to grade their submission.  If it passes, they will get an unlock code to the next level.


-----

welcome - install luvit and click link (no test)
tcp-server - TCP Server (Echo server) coro-net and node-style
tcp-client - TCP Client (HTTP primitive client) coro + node
http-server - HTTP Server (JSON response with content-type header and method/pathname)
http-client - HTTP Client (PUT JSON with magic key)

weblit - Weblit test a few routes
websocket - Websocket  echo server

luvbot - use gamepad or termbox and control bot over tcp
limitless - Limitless LEDs (raffle) - use udp to change color

Demo:

  FS / Coro-FS
  Luvi APPs
  Publishing to Lit
  Joystick Stream
  Joystick FS
