local connect = require('net').connect

local socket
socket = connect(1337, "127.0.0.1", function (err)
  assert(not err, err)
  local line = "GET /tcp-client/2e507601162bf541bcdd04ae73b35649f92e24d9 HTTP/1.0\r\n\r\n"
  socket:write(line)
  socket:_end()
end)
