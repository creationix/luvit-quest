LuvBot

This challenge is to remote control my robot using a provided USB gamepad.

You'll need to do the following:

 - Install the `creationix/gamepad` library to get access to a C library with
   Luajit FFI bindings for cross-platform gamepad support.
 - Using the C interface, poll for gamepads and read axis movement events.
 - Create a TCP client to connect to the robot.
 - When the gamepad moves, send bytecode snippets to the robot's VM to execute.

## uScript

The language is based on an expression tree, for example a program to add 1 and
2, you would do:

```uScript
ADD 1 2
```

Which should be sent as the three bytes `0x03 0x91 0x01 0x02`.  The initial 3 is
the length header of the body.

Numbers are encoded in a variable length format.  All numbers between 0 and 63
are represented by themselves.  If the number is between 64 and 127, the lower
6 bits are used as value and the next byte is read.  Then the next byte will
use the high bit for continue and the 7 lower bits for value.  Each new byte
will shift the current value left 7 bits.

```lua
local config = {
  host = "192.168.43.219",
  port = 1337
}

local EMPTY = 128 -- internal opcode for consuming arguments
local DO, DOING, END = 129, 130, 131 -- Run all expressions inside returning last value.
local RETURN = 132 -- (value) return early from DO..END with value.
local YIELD = 133 -- Pauses the current thread, putting it at the end of the event queue.
local DELAY = 134 -- (ms) Pause, but don't resume till after delay timeout.
local PM = 135 -- (pin, mode) Set Pin Mode
local DW = 136 -- (pin, value) Digital write to pin
local DR = 137 -- (pin) Digital read from pin
local AW = 138 -- (pin, value) Analog (pwm) write to pin
local AR = 139 -- (pin) Analog read from pin
local NOT = 140 -- (val) logical NOT
local AND = 141 -- (val, val) logical AND with value preservation and short-circuit
local OR = 142 -- (val, val) logical OR with value preservation and short-circuit
local XOR = 143 -- (val, val) logic XOR with value preservation
local NEG = 144 -- (val) negate a value
local ADD = 145 -- (val, val) Add two values
local SUB = 146 -- (val, val) subtract two values
local MUL = 147 -- (val, val) multiple two values
local DIV = 148 -- (val, val) divide two values
local MOD = 149 -- (val, mod) modulus of two values
local GT = 150  -- (val, val) greater than
local LT = 151  -- (val, val) less than
local GTE = 152 -- (val, val) greater than or equal
local LTE = 153 -- (val, val) less than or equal
local EQ = 154  -- (val, val) equal
local NEQ = 155 -- (val, val) not equal
local SRAND = 156 -- (seed) seed for PRNG
local RAND = 157 -- (mod) generate new PRNG and modulus the output
local IF, THEN, ELIF, ELSE = 158, 159, 160, 161 -- if (cond) {body} elif (cond) {body} else {body}
local WHILE = 162 -- *(cond) {body} repeatedly run body while condition is true.
local WAIT = 163 -- (cond) repeatedly run condition till it's true.
local DEF = 164 -- *(id, nargs) {body} define an expression
local CALL = 165 -- *(id, args...) run expression at target address and pass through value.
local TCALL = 166 -- *(id, args...
local N0 = 16
local N1 = 5
local N2 = 4
local N3 = 0
```
