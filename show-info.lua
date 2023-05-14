-- Config
local redstoneSide = "right"
local recvChan = 22
local sendChan = 21

-- Code
local modem = peripheral.find("modem")
local monitor = peripheral.find("monitor")
monitor.setTextScale(0.5)
local mymath = require("mymath")
modem.open(recvChan)

while true do
    -- grab info
    local event, side, channel, replyChannel, message, distance, button, x, y
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == recvChan

    message.fuel = mymath.round(message.fuel/1000,0)
    message.coolant = mymath.round(message.coolant/1000,0)
    message.temp = mymath.round(message.temp,0)

    monitor.clear()

    if message.status then
        monitor.setTextColor(colors.green)
        monitor.setCursorPos(1,1)
        monitor.write("Activated")
        monitor.setTextColor(colors.white)
        monitor.setCursorPos(1,2)
        monitor.write("Fuel: " .. message.fuel .. "B")
        monitor.setCursorPos(1,3)
        monitor.write("Cool: " .. message.coolant .. "B")
        monitor.setCursorPos(1,4)
        monitor.write("Temp: " .. message.temp .. "K")
        monitor.setCursorPos(1,5)
        monitor.write("Wast: " .. message.waste .. "mB")
    else
        monitor.setTextColor(colors.red)
        monitor.setCursorPos(1,1)
        monitor.write("Reactor Deactivated")
        monitor.setBackgroundColor(colors.red)
        monitor.setTextColor(colors.white)
        monitor.setCursorPos(1,2)
        monitor.write("CLICK TO STOP")
        monitor.setCursorPos(1,3)
        monitor.write("ALARM")

        redstone.setOutput(redstoneSide, true)
        repeat
            event, button, x, y = os.pullEvent("monitor_touch")
        until y > 0
        redstone.setOutput(redstoneSide, false)
        monitor.setBackgroundColor(colors.black)
    end


end