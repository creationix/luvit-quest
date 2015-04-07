
## Grogging co-routines and node callbacks

The libuv bindings to Luvi do not require you to use callbacks; coroutines
are another option. Coroutines let you write code in a blocking style.
In this quest, you will have the options of using either method of your
choosing to write an echo TCP/IP server.

## Coroutines

package.lua:

```lua
return {
  name = "quests/tcp-server",
  dependencies = {
    "luvit/require@1.0.1",
    "luvit/pretty-print@1.0.0",
    "creationix/coro-tcp@1.0.5",
    "creationix/coro-wrapper@1.0.0",
  },
}
```

*Don't forget to `lit install` your dependencies!*

tcpechoserver.lua:

```lua
local uv = require('uv')
coroutine.wrap(function ()
  -- Insert code here
end)()
uv.run()
```

Run your server with:

```sh
luvit tcpechoserver.lua
```

## Callbacks

package.lua:

```lua
return {
  name = "quests/tcp-server",
  dependencies = {
    "luvit/luvit@2.0.4"
  },
}
```

tcpechoserver.lua:

```lua
local net = require('net')
local server = net.createServer...
-- Insert code here
```

*Don't forget to `lit install` your dependencies!*

```sh
luvit tcpechoserver.lua
```
