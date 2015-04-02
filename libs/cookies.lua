
return function (req, res, go)
  local cookies = {}
  req.cookies = cookies
  for i = 1, #req.headers do
    local key, value = unpack(req.headers[i])
    if key:lower() == "cookie" then
      for k, v in value:gmatch("([^;=]+)=([^;=]+)") do
        cookies[k] = v
      end
    end
  end
  local headers = res.headers
  function res.setCookie(key, value)
    cookies[key] = value
    headers[#headers + 1] = {"Set-Cookie", key .. "=" .. value}
  end
  return go()
end
