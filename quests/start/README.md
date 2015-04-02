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

