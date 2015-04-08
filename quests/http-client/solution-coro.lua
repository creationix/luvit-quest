local request = require('coro-http').request
local jsonStringify = require('json').stringify

coroutine.wrap(function ()
  local headers = {
    {"User-Agent", "Chaotic Evil High Elf (1530e4f5)"},
    {"Connection", "close"},
    {"Content-Type", "application/json"},
  }
  local url = "http://127.0.0.1:1337/http-client/ecf8858abee08b3c825d32d7bc76fbd943654a3b"
  local json = jsonStringify({
    name = "Tim Casewll",
    message = "This is Epic!",
  })
  local res, body = request("PUT", url, headers, json)
  p(res, body)
end)()
