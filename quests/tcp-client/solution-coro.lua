local connect = require('coro-tcp').connect

coroutine.wrap(function ()
  local line = "GET /tcp-client/d0bef28e2bb78b92e8e2db48e4072b5f44ef2042 HTTP/1.0\r\n\r\n"
  local read, write = connect("127.0.0.1", 1337)
  write(line)
  write()
  for data in read do
    p(data)
  end
end)()
