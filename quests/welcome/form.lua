
return function (req, res)
  local ip = req.socket:getpeername().ip
  res.body = res.body:gsub("<!%-%-fields%-%->",
    '<form method="POST" action="/welcome/test">' ..
      '<input name="host" type="text" value="' .. ip .. '">' ..
      '<input name="port" type="text" value="8080">' ..
      '<input type="submit" value="Test My Server">' ..
    '</form>'
  )
end
