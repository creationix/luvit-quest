local renderTemplate = require('render-template')
local pathJoin = require('luvi').path.join
local fs = require('coro-fs').chroot(pathJoin(module.dir, "quests"))

local app = require('weblit-app')
app
  .bind({host="0.0.0.0", port="1337"})

  .use(require('session-logger'))
  .use(require('weblit-auto-headers'))

  .use(require('cookies'))
  .use(require('sessions')("litup"))

  .use(function (_, res, go)
    function res.teleport(name)
      res.setCookie(name, res.keygen(name), {Path="/"})
      res.code = 302
      res.headers.Location = "/" .. name .. ".html"
    end
    return go()
  end)

  -- Redirect to start quest
  .route({
    method = "GET",
    path = "/"
  }, function (_, res)
    return res.teleport("welcome")
  end)

  -- Match the instructions
  .route({
    method = "GET",
    path = "/:name.html"
  }, function (req, res, go)
    local name = req.params.name
    local readme = fs.readFile(pathJoin(name, "README.md"))

    if not readme then return go() end
    if not req.validate(name) then return end
    renderTemplate(res, "quest", {
      name = name,
      readme = readme
    })
    require('./quests/' .. name .. '/form')(req, res)
  end)

  .use(require('weblit-static')(pathJoin(module.dir, "static")))

  .start()

coroutine.wrap(function ()
  for entry in fs.scandir(".") do
    require('./quests/' .. entry.name .. '/route')(app)
  end
end)()
