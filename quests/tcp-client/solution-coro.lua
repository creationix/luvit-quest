local connect = require('coro-tcp').connect

coroutine.wrap(function ()
  local line = "GET /tcp-client/40601d882a658ec8fb1509fa81574afdfb02d4a7 HTTP/1.0\r\n\r\n"
  local read, write = connect("127.0.0.1", 1337)
  write(line)
  write()
  for data in read do
    p(data)
  end
end)()
