-- Config
local redstoneSide = "right"
local recvChan = 22
local sendChan = 21

-- Code
local modem = peripheral.find("modem")
local monitor = peripheral.find("monitor")
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
        monitor.write("Reactor Activated\n")
        monitor.setTextColor(colors.white)
        monitor.write("Fuel: " .. message.fuel .. " B\n")
        monitor.write("Coolant: " .. message.coolant .. " B\n")
        monitor.write("Temp: " .. message.temp .. " K\n")
        monitor.write("Waste: " .. message.waste .. " mB\n")
    else
        monitor.setTextColor(colors.red)
        monitor.write("Reactor Deactivated\n")
        monitor.setBackgroundColor(colors.red)
        monitor.setTextColor(colors.white)
        monitor.write("CLICK TO STOP\nALARM")

        redstone.setOutput(redstoneSide, 15)
        repeat
            event, button, x, y = os.pullEvent("monitor_touch")
        until y > 0
        redstone.setOutput(redstoneSide, 0)
    end


    sleep(1)
end