local request = require('coro-http').request
local jsonStringify = require('json').stringify

coroutine.wrap(function ()
  local headers = {
    {"User-Agent", "%PLAYER"},
    {"Content-Type", "application/json"},
  }
  local url = "http://%HOST:%PORT/http-client/%HASH"
  local json = jsonStringify({
    name = "Tim Casewll",
    message = "This is Epic!",
  })
  local res, body = request("PUT", url, headers, json)
  p(res, body)
end)()
