local connect = require('coro-tcp').connect

coroutine.wrap(function ()
  local line = "GET /tcp-client/0b8b0122fe694d18de755e71d7fdce4b9c624fed HTTP/1.0\r\n\r\n"
  local read, write = connect("127.0.0.1", 1337)
  write(line)
  write()
  for data in read do
    p(data)
  end
end)()
