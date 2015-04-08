local static = require('weblit-static')
local env = require('env')

local function on_hello(req, res)
end

require('weblit-app')
.bind({host = "127.0.0.1", port = env.get("PORT") or 8080})
.route({ method = "POST", path = "/hello" }, on_hello)
.start()
