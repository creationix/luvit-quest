
Your task is now to conjure a local HTTP server that will respond to all requests
with a JSON document containing the HTTP `method` and `pathname` of the request.

## Coro Style

If using coro style, you'll want something like the `creationix/coro-http` library to help you out.

```sh
lit install creationix/coro-http
```

Use the following to get started.  Save it as `http-server.lua`.

```lua
local createServer = require('coro-http').createServer
local jsonStringify = require('json').stringify
local urlParse = require('url').parse

createServer("0.0.0.0", 8080, function (head, body)
  -- Replace with new head and body
  return {
    code = 200,
    {"Server", "My Server"},
    {"Content-Type", "text/plain"},
    {"Content-Length", 12},
  }, "Hello World\n"
end)
```

The `coro-http` library provides a simple blocking interface to `http-codec`.

The `head` tabke for request and response heads has keys like `method`,
`path`, `code`, etc and numerical indexed headers as table pairs.

 - `head.method` - HTTP method of request
 - `head.path` -  as table pairs and the code among other values.  Then there are zero or more
 - `json.stringify(value)` - Serialize a value to a JSON string.
 - `url.parse(url)` - Parse a url to get things like `pathname`.


## Node Style

Use the following to get started.  Save it as `http-server.lua`.

```lua
local createServer = require('http').createServer
local jsonStringify = require('json').stringify
local urlParse = require('url').parse

createServer(function (req, res)
  -- Insert code here
end):listen(8080, "0.0.0.0")

print("HTTP Server listening at http://localhost:8080")
```

The following API interfaces will be helpful in solving this task:

 - `req.method` - contains the HTTP request method as a string like `"GET"`.
 - `req.url` - contains the HTTP request path including query string but not
    domain or protocol.  For example `"/red/mage?spell=magic+missile"`.
 - `res:writeHead(code, headers)` - Set response head with HTTP status code as
    number and headers as key-value table. Example:
    `res:writeHead(200, {["Content-Type"] = "text/plain"})`
 - `res:setHeader(key, value)` - Set a single http header.  Head will flush
    automatically later if needed.
 - `res:finish(value)` - Send the response body as a single chunk and end the
    stream. Example: `res:finish("Hello World\n")`
 - `json.stringify(value)` - Serialize a value to a JSON string.
 - `url.parse(url)` - Parse a url to get things like `pathname`.

## Test It!

And then run the server using luvit.

```sh
luvit http-server.lua
```

Once you have a local server that does what it should, tell the dungeon master
to check your incantation.  If it passes, you'll be teleported to the next
challenge.
