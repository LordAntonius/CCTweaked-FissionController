-- Config
local redstoneSide = "right"
local recvChan = 22
local sendChan = 21

-- Code
local modem = peripheral.find("modem")


local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == recvChan

local fuel, coolant, temp, waste, status = message

print(message)