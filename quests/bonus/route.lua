
return function (app)
  app.route({
    method = "POST",
    path = "/bonus/weblit"
  }, function (req, res)
    return res.teleport("weblit-framework")
  end)
  app.route({
    method = "POST",
    path = "/bonus/luvbot"
  }, function (req, res)
    return res.teleport("luvbot")
  end)
end

