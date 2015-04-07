local createServer = require('coro-http').createServer
local jsonStringify = require('json').stringify
local urlParse = require('url').parse

createServer("0.0.0.0", 8080, function (head)
  -- Replace with new head and body
  local json = jsonStringify({
    method = head.method,
    pathname = urlParse(head.path).pathname
  })
  return {
    code = 200,
    {"Server", "Gandalf the White"},
    {"Content-Type", "application/json"},
    {"Content-Length", #json},
  }, json
end)
