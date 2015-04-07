local createServer = require('coro-http').createServer

createServer("0.0.0.0", 8080, function (head, body, respond)
  p(head, body)
  respond({
    code = 200,
    {"Server", "My Server"},
    {"Content-Type", "text/plain"},
    {"Content-Length", 12},
  }, "Hello World\n")
end)
