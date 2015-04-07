return function (app)
  app.route({
    method = "GET",
    path = "/welcome/test"
  }, function (req, res)
    if not req.validate("welcome") then return end
    return res.teleport("tcp-server")
  end)
end

