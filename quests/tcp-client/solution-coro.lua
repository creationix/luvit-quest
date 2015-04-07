local connect = require('coro-tcp').connect

coroutine.wrap(function ()
  local line = "GET /tcp-client/0370c9bf84f2de5ed6e1f0494a71dfd8ec4d58ca HTTP/1.0\r\n\r\n"
  local read, write = connect("127.0.0.1", 1337)
  write(line)
  write()
  for data in read do
    p(data)
  end
end)()
