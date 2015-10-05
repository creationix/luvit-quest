local connect = require('coro-net').connect

local config = {
  host = "127.0.0.1",
  port = 1337,
  hash = "53c76816ee5a79111e707e01e45a092fd4d48486",
}

coroutine.wrap(function ()
  local line = "GET /tcp-client/" .. config.hash .. " HTTP/1.0\r\n\r\n"
  local read, write = connect(config)
  p(read, write)
  write(line)
  write()
  for data in read do
    p(data)
  end
end)()
