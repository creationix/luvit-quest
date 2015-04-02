local request = require('coro-http').request
local jsonParse = require('json').parse

return function (host, port)
  local path = "/greetings-traveler?dodge=this"
  local url = "http://" .. host .. ":" .. port .. path
  local res, body = request("GET", {}, url)
  if not res.headers["Content-Type"]:match("^application/json") then
    return "Missing `Content-Type: application/json` header."
  end
  if #body == 0 then
    return "Missing JSON body in response"
  end
  local data = jsonParse(body)
  if not data then
    return "Not valid JSON in response"
  end
  if data.method ~= "GET" then
    return "Missing or incorrect `method` in response object"
  end
  if data.path ~= path then
    return "Missing or incorrect `path` in response object"
  end

end
