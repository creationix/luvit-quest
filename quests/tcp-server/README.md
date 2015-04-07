
## Grogging co-routines and node callbacks

The libuv bindings to Luvi do not require you to use callbacks; coroutines
are another option. Coroutines let you write code in a blocking style.
In this quest, you will have the options of using either method of your
choosing to write an echo TCP/IP server.

## Coroutine Style

For Coroutine style, we need a library not included with luvit core.  Let's
install that using `lit`. tcpechoserver.lua:

```sh
lit install creationix/coro-tcp
```

Then create your `tcp-server.lua` file using the following as a starting point.

```lua
local createServer = require('coro-tcp').createServer

coroutine.wrap(function ()
  createServer("0.0.0.0", 3000, function (read, write)
    -- Insert code here
  end)
end)()
```

## Node.JS Style

Create a `tcp-server.lua` file for your quest entry.

```lua
local createServer = require('net').createServer
createServer(function (socket)
  -- Insert code here
end):listen(3000, "0.0.0.0")
print("TCP server running")
```

## Test It!

Once you've written your file, run it with `luvit`.

```sh
luvit tcp-server.lua
```

You can test this locally using telnet or netcat to localhost port 3000.

Enter your port and ip below to test and move to the next challenge.

