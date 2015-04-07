local connect = require('net').connect

local socket
socket = connect(1337, "127.0.0.1", function (err)
  assert(not err, err)
  local line = "GET /tcp-client/0370c9bf84f2de5ed6e1f0494a71dfd8ec4d58ca HTTP/1.0\r\n\r\n"
  socket:write(line)
  socket:_end()
end)
