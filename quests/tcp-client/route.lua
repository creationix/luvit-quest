return function (app)

  local clients = {}
  local page = "tcp-client"
  local nextPage = "http-server"

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
    method = "GET",
    path = "/" .. page .. "/:hash"
  }, function (req, res)
    local key = req.params.hash
    local thread = clients[key]
    if not thread then return end
    clients[key] = nil
    res.code = 200
    res.body = "Success!\n"
    coroutine.resume(thread, nextPage)
  end)
end
