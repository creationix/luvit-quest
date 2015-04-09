return function (req, res)
  res.body = res.body:gsub("<!%-%-fields%-%->",
    '<p><form method="POST" action="/bonus/weblit">' ..
      '<input type="submit" value="Weblit">' ..
    '</form></p>'..
    '<p><form method="POST" action="/bonus/luvbot">' ..
      '<input type="submit" value="Luvbot">' ..
    '</form></p>'
  )
end
