local request = require('coro-http').request
local queryParse = require('querystring').parse
local jsonParse = require('json').parse

return function (app)
  app.route({
    method = "POST",
    path = "/http-server/test"
  }, function (req, res)
    if not req.validate("http-server") then return end
    local config = queryParse(req.body)
    local secret = string.format("/%x", math.random(0x100000000))
    local url = string.format("http://%s:%s%s?ignore=me",
      config.host,
      config.port,
      secret)

    local head, body = request("GET", url)
   local data = jsonParse(body)

    if not data then
      error("NOT JSON IN RESPONSE")
    end
    if head.code == 200 and data.pathname == secret and data.method == "GET" then
      return res.teleport("coro")
    end
    error("Invalid response data")
  end)
end
