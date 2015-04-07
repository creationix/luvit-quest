In this level, you'll create a TCP client connection and send a primitive HTTP
request by manually sending the HTTP data over the TCP socket.

We've setup a special endpoint in the dungeion master server that you need to
make your request to, the following values will be useful:

```lua
local config = {
  host = %HOST,
  port = %PORT,
  line = %LINE,
}
```

## Coroutine Style

Again, we'll need coro-tcp if you don't have it installed already.

```sh
lit install creationix/coro-tcp
```

Then create your `tcp-client.lua` file using the following as a starting point.

```lua
local connect = require('coro-tcp').connect

coroutine.wrap(function ()
  local line = %LINE
  local read, write = connect(%HOST, %PORT)
  -- Insert code here
end)()
```

In this version you'll likely want the following APIs:

 - `read()` - A blocking read that returns the next item in the stream and nil
   when the stream closes.
 - `write(item)` - A blocking write, pass in null to send EOS.

Hint, you can use `for item in read do ... end` to loop over the stream.
Don't forget to send EOS after the loop ends.

## Node Style

With the node style APIs, start with the following `tcp-client.lua` file.

```lua
local connect = require('net').connect

local socket
socket = connect(%PORT, %HOST, function (err)
  assert(not err, err)
  local line = %LINE
  -- Insert code here
end)
```

In this version you'll likely want the following APIs:

 - `stream:write(data)` - To write data on the socket
 - `stream:_end()` - To send EOS


## Test It!

Once you've written your file, run it with `luvit`.

```sh
luvit tcp-client.lua
```

This page contains a long-poll connection to the backend that's waiting for your request.

It will automatically move on to the next step if you send the correct data.
