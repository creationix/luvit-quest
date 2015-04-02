local markdown = require('markdown')
local pathJoin = require('luvi').path.join
local fs = require('coro-fs').chroot(pathJoin(module.dir, "quests"))

-- Lazy load quests on server start
local quests
local function loadQuests()
  quests = {}
  for entry in fs.scandir(".") do
    quests[#quests + 1] = entry
  end
end

require('weblit-app')
  .bind({host="0.0.0.0", port="1337"})

  .use(require('session-logger'))
  .use(require('weblit-auto-headers'))

  .use(require('cookies'))
  .use(require('sessions')("litup"))

  -- Redirect to start quest
  .route({
    method = "GET",
    path = "/"
  }, function (req, res, go)
    res.code = 302
    res.headers.Location = "/" .. res.keygen("start")
  end)

  .route({
    method = "GET",
    path = "/:hash"
  }, function (req, res, go)
    local hash = req.params.hash
    local match
    if not quests then loadQuests() end
    for i = 1, #quests do
      local entry = quests[i]
      if hash == res.keygen(entry.name) then
        match = entry
        break
      end
    end
    if not match then return go() end
    res.code = 200
    res.headers["Content-Type"] = "text/html"
    local readme = fs.readFile(pathJoin(match.name, "README.md"))
    res.body = markdown(readme)
  end)

  .start()
