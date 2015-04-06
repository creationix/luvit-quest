
return function (req, res, go)
  local cookies = {}
  req.cookies = cookies
  for i = 1, #req.headers do
    local key, value = unpack(req.headers[i])
    if key:lower() == "cookie" then
      for k, v in value:gmatch("([^ ;=]+)=([^;=]+)") do
        cookies[k] = v
      end
    end
  end
  local headers = res.headers
  function res.setCookie(key, value, props)
    cookies[key] = value
    local cookie = key .. "=" .. value
    for k, v in pairs(props) do
      cookie = cookie .. "; " .. k .. '=' .. v
    end
    headers[#headers + 1] = {"Set-Cookie", cookie}
  end
  return go()
end
