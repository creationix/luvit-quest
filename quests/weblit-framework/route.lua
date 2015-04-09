local request = require('coro-http').request
local queryParse = require('querystring').parse
local jsonParse = require('json').parse
local jsonStringify = require('json').stringify

return function (app)
  app.route({
    method = "POST",
    path = "/weblit-framework/test"
  }, function (req, res)
    if not req.validate("weblit-framework") then return end
    local config = queryParse(req.body)
    local url = string.format("http://%s:%s/hello",
      config.host,
      config.port)

    local postBody = jsonStringify({ message = "world" })
    local head, body = request("POST", url, {}, postBody)
    local data = jsonParse(body)

    if not data then
      error("NOT JSON IN RESPONSE")
    end
    if head.code == 200 and data.message:lower() == "hello world" then
      return res.teleport("welcome")
    end
    error("Invalid response data")
  end)
end

