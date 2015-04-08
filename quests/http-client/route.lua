local jsonParse = require('json').parse

return function (app)

  local clients = {}
  local page = "http-client"
  local nextPage = "bonus"

  app.route({
    method = "GET",
    path = "/" .. page .. "/push"
  }, function (req, res)
    if not req.validate(page) then return end
    local key = res.keygen(page)
    clients[key] = coroutine.running()
    print("Long-poll " .. page .. " Waiting " .. req.cookies.player)
    local target = assert(coroutine.yield())
    print("Long-poll " .. page .. " Done " .. req.cookies.player)
    res.body = "/" .. target .. ".html"
    res.setCookie(target, res.keygen(target), {Path="/"})
    res.code = 200
  end)
  app.route({
    method = "PUT",
    path = "/" .. page .. "/:hash"
  }, function (req, res)
    local key = req.params.hash
    local thread = clients[key]
    if not thread then return end
    clients[key] = nil
    p(req)
    if not req.body then
      error("Missing body")
    end
    local json = jsonParse(req.body)
    if not json then
      error("Body is not valid JSON")
    end
    if not (json.name and json.message) then
      error("Missing name or message in json body")
    end
    if req.headers["Content-Type"] ~= "application/json" then
      error("Missing 'Content-Type: application/json' header")
    end
    res.code = 200
    res.body = "Welcome " .. req.cookies.player .. "!\n"
    coroutine.resume(thread, nextPage)
  end)
end
