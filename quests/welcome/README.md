Welcome to Luvit-Quest.

## Gird Thyself With Proper Attire

Before beginning the quest, you must first install the latest `luvit` and `lit`
tools into your computer.  The [install][] link at top will take you to the
official luvit installation instructions.

[install]: https://luvit.io/install.html

Once you have `luvit` and `lit` installed, create a training area (directory)
so you have a place to work.

```sh
mkdir quests
cd quests
```

## But First a Small Test

Your first test is a simple one to make sure you have the hang of this before
we start teaching you advanced spells or skills.

Your task is to conjure a local HTTP server that will respond to all requests
with a JSON document containing the HTTP `method` and `pathname` of the request.

The following shell will get you started:

```lua
-- Load the node-style HTTP library
local http = require('http')
-- Load the JSON encoder
local jsonStringify = require('json').stringify

-- Create an HTTP server node-style.
local server = http.createServer(function (req, res)

  -- Insert code here

end)

-- Bind to port 8080 and start listening
server:listen(8080)

-- Print a nice message so you know it got this far
print("HTTP Server listening at http://localhost:8080")
```

And then run the server using luvit.

```sh
luvit server.lua
```

## API Hints

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

Once you have a local server that does what it should, tell the dungeon master
to check your incantation.  If it passes, you'll be teleported to the next
challenge.
