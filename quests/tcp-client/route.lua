return function (app)

  local clients = {}

  app.route({
    method = "GET",
    path = "/tcp-client/push"
  }, function (req, res)
    if not req.validate("tcp-client") then return end
    local key = res.keygen("tcp-client")
    clients[key] = coroutine.running()
    print("Long-poll Waiting " .. req.cookies.player)
    res.body = assert(coroutine.yield())
    print("Long-poll Done " .. req.cookies.player)
    res.setCookie("http-server", res.keygen("http-server"), {Path="/"})
    res.code = 200
  end)
  app.route({
    method = "GET",
    path = "/tcp-client/:hash"
  }, function (req, res)
    local key = req.params.hash
    local thread = clients[key]
    if not thread then return end
    clients[key] = nil
    res.code = 200
    res.body = "Success!\n"
    coroutine.resume(thread, "/http-server.html")
  end)
end
