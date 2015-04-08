local request = require('http').request
local jsonStringify = require('json').stringify

local req = request({
  host = "127.0.0.1",
  port = 1337,
  method = "PUT",
  path = "/http-client/0b9cee3e497008f14d185b97ca1d453b450f7ff7",
  headers = {
    {"User-Agent", "Chaotic Evil High Elf (1530e4f5)"}
  },
}, function (err)
  assert(not err, err)
end)

local json = jsonStringify({
  name = "Tim Casewll",
  message = "This is Epic!",
})

req:write(json)
req:done()
