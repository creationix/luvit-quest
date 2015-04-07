
local createServer = require('net').createServer

createServer(function(sock)
  -- Echo back all input as output
  sock:pipe(sock)
end):listen(8081, '0.0.0.0')

print('listening on 127.0.0.1:3000')
