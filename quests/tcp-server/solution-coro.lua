local createServer = require('coro-net').createServer

local config = {
  host = "0.0.0.0",
  port = 3000,
}

createServer(config, function (read, write)
  -- Echo back all input as output
  for data in read do
    write(data)
  end
  write()
end)

print('listening on 127.0.0.1:3000')
