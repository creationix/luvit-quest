This adventure takes you on a stroll down weblit lane. Weblit is an
express-like framework for `lit` that uses coro style.

In this adventure you will need to write a weblit REST service that allows a
JSON `POST` to `/hello`. The service will need to accept this Lua object
encoded as JSON:

```lua
{
  message = "world"
}
```

The response should be the following payload in JSON:

```lua
{
  message = "hello world"
}
```

## Installing Weblit

```sh
lit install creationix/weblit
```

Use the following to get started. Save it as `weblit-server.lua`.

```lua
local jsonStringify = require('json').stringify

local function on_hello(req, res)
 -- req.method
 -- req.path
 -- req.params
 -- req.headers
 -- req.version
 -- req.keepAlive
 -- req.body

 -- res.code
 -- res.headers
 -- res.body
end

require('weblit-app')
.bind({host = "127.0.0.1", port = 8080})
.route({ method = "POST", path = "/hello" }, on_hello)
.start()
```
