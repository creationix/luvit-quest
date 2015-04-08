return function (app)
  app.route({
    method = "GET",
    path = "/weblit-framework"
  }, function (req, res)
    return res.teleport("weblit-framework")
  end)
end

