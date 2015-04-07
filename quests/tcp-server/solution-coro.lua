local createServer = require('coro-tcp').createServer

createServer("0.0.0.0", 3000, function (read, write)
  -- Echo back all input as output
  for data in read do
    write(data)
  end
  write()
end)

print('listening on 127.0.0.1:3000')
