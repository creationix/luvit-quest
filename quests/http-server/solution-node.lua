local createServer = require('http').createServer
local jsonStringify = require('json').stringify
local urlParse = require('url').parse

createServer(function (req, res)
  print("Request made")
  res:setHeader("Content-Type", "application/json")
  res:finish(jsonStringify({
    method = req.method,
    pathname = urlParse(req.url).pathname
  }))
end):listen(8080, "0.0.0.0")

print("HTTP Server listening at http://localhost:8080")
