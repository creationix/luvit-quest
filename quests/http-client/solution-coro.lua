local request = require('coro-http').request
local jsonStringify = require('json').stringify

coroutine.wrap(function ()
  local headers = {
    {"User-Agent", "Chaotic Evil High Elf (1530e4f5)"},
    {"Connection", "close"},
    {"Content-Type", "application/json"},
  }
  local url = "http://127.0.0.1:1337/http-client/0b9cee3e497008f14d185b97ca1d453b450f7ff7"
  local json = jsonStringify({
    name = "Tim Casewll",
    message = "This is Epic!",
  })
  local res, body = request("PUT", url, headers, json)
  p(res, body)
end)()
