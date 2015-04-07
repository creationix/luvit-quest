
return function (req, res)
  res.body = res.body:gsub("<!%-%-fields%-%->",
    '<p><form method="GET" action="/welcome/test">' ..
      '<input type="submit" value="Begin thy Quest!">' ..
    '</form></p>'
  )
end

