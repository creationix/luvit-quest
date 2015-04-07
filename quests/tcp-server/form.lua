return function (req, res)
  local ip = req.socket:getpeername().ip
  res.body = res.body:gsub("<!%-%-fields%-%->",
    '<p><form method="POST" action="/tcp-server/test">' ..
      '<label for="host">Host:<input name="host" type="text" value="' .. ip .. '"></label>' ..
      '<label for="port">Port:<input name="port" type="text" value="8081"></label>' ..
      '<input type="submit" value="Test My Server">' ..
    '</form></p>'
  )
end
