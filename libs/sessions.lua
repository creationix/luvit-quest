local digest = require('openssl').digest.digest

local races = { "Dragonborn", "Dwarf", "Eladrin", "Elf", "High Elf", "Gnome",
  "Rock Gnome", "Half-elf", "Half-orc", "Halfling", "Human", "Tiefling" }

local alignments = { "Lawful Good", "Neutral Good", "Chaotic Good",
  "Lawful Neutral", "True Neutral", "Chaotic Neutral", "Lawful Evil",
  "Neutral Evil", "Chaotic Evil" }

return function (secret)
  return function (req, res, go)
    if not req.cookies.player then
      res.setCookie("player", string.format("%s %s (%x)",
        alignments[math.random(#alignments)],
        races[math.random(#races)],
        math.random(0x100000000)
      ), {Path="/"})
    end
    function req.validate(name)
      local key = res.keygen(name)
      if key ~= req.cookies[name] then
        res.code = 412
        res.headers["Content-Type"] = "text/plain"
        res.body = req.cookies.player .. " has yet to aquire the key to " .. name .. ".\n"
        return false
      end
      return true
    end
    local player = req.cookies.player
    function res.keygen(label)
      local key = player .. secret .. label
      return digest("sha1", #key .. key .. "\0")
    end

    return go()
  end
end
