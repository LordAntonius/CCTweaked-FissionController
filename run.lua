-- Config
local reactorSide = "bottom"
local wasteLimit = 10
local tempLimit = 600
local recvChan = 21
local sendChan = 22

local reactor = peripheral.wrap(reactorSide)
local modem = peripheral.find("modem")

while true do
    if reactor.getStatus() then
        if reactor.getWaste().amount > wasteLimit then
            reactor.scram()
            print("Too much waste ! ABORT SYSTEM")
        end
        if reactor.getTemperature() > tempLimit then
            reactor.scram()
            print("Not enough coolant ! ABORT SYSTEM")
        end
    end

    -- Transmit msg
    local msg = {
        fuel = reactor.getFuel().amount,
        coolant = reactor.getCoolant().amount,
        temp = reactor.getTemperature(),
        waste = reactor.getWaste().amount,
        status = reactor.getStatus()

    }
    modem.transmit(sendChan, recvChan, msg)
    sleep(1)
end

--getFuel().amount
--getCoolant().amount