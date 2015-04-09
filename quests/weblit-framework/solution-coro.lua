local jsonStringify = require('json').stringify

local function on_hello(req, res)
  local body = jsonStringify({ message = "hello world" })
  res.headers = {
    { 'Content-Type', 'application/json' },
    { 'Content-Length', #body },
  }
  res.code = 200
  res.body = body
end

require('weblit-app')
.bind({host = "0.0.0.0", port = 8080})
.route({ method = "POST", path = "/hello" }, on_hello)
.start()
