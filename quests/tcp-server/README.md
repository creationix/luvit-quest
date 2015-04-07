
## Grogging co-routines and node callbacks

The libuv bindings to Luvi do not require you to use callbacks; coroutines
are another option. Coroutines let you write code in a blocking style.
In this quest, you will have the options of using either method of your
choosing to write an echo TCP/IP server.

## Coroutine Style

For Coroutine style, we need a library not included with luvit core.  Let's
install that using `lit`.

```sh
lit install creationix/coro-tcp
```

Then create your `tcp-server.lua` file using the following as a starting point.

```lua
local createServer = require('coro-tcp').createServer

createServer("0.0.0.0", 3000, function (read, write)
  -- Insert code here
end)
  ```

In this version you'll likely want the following APIs:

 - `read()` - A blocking read that returns the next item in the stream and nil
   when the stream closes.
 - `write(item)` - A blocking write, pass in null to send EOS.

Hint, you can use `for item in read do ... end` to loop over the stream.
Don't forget to send EOS after the loop ends.


## Node.JS Style

Create a `tcp-server.lua` file for your quest entry.

```lua
local createServer = require('net').createServer
createServer(function (socket)
  -- Insert code here
end):listen(3000, "0.0.0.0")
print("TCP server running")
```

In this version you'll likely want the following APIs:

 - `stream:pipe(targetStream)` - Connect a stream to another stream. (Hint the socket is a duplex stream)

## Test It!

Once you've written your file, run it with `luvit`.

```sh
luvit tcp-server.lua
```

You can test this locally using telnet or netcat to localhost port 3000.

Enter your port and ip below to test and move to the next challenge.

