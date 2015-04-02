return function (req, res, go)
  go()
  -- And then log after everything is done
  print(string.format("%s %s %s %s", req.method, req.path, req.cookies.player, res.code))
end
