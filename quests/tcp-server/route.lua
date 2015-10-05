local queryParse = require('querystring').parse
local tcp = require('coro-net')
return function (app)
  app.route({
    method = "POST",
    path = "/tcp-server/test"
  }, function (req, res)
    if not req.validate("tcp-server") then return end
    local config = queryParse(req.body)
    local read, write = tcp.connect(config)
    if not read then error(write) end
    local signal = 'guybrush threepwood'
    write(signal)
    local data = read()
    if data == signal then return res.teleport("tcp-client") end
  end)
end
