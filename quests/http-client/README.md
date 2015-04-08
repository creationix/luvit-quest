Now for the final training quest and then you will start on real adventures!

Please send us a JSON scroll via HTTP PUT containing the following information
based on your feelings towards the training academy so far.

```lua
{
  name = "Your Name",
  message = "A message"
}
```

You need to include the `Content-Type: application/json` header and make a `PUT`
request with the payload as JSON.

## Coro Style

If using coro style, you'll want something like the `creationix/coro-http`
library to help you out.

```sh
lit install creationix/coro-http
```

Use the following to get started.  Save it as `http-client.lua`.

```lua
local request = require('coro-http').request
local jsonStringify = require('json').stringify

coroutine.wrap(function ()
  local headers = {
    {"User-Agent", "%PLAYER"},
    {"Connection", "close"},
    -- Add more headers here
  }
  local url = "http://%HOST:%PORT/http-client/%HASH"
  local json = "{}" -- Replace with real body
  local res, body = request("PUT", url, headers, json)
  p(res, body)
end)()
```

## Node Style

```lua
local request = require('http').request

local req
req = http.request({
  host = "%HOST",
  port = %PORT,
  method = "PUT",
  path = "/http-client/%HASH",
}, function)
```
