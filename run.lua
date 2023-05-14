-- Config
local reactorSide = "bottom"
local wasteLimit = 10
local tempLimit = 400

local reactor = peripheral.wrap(reactorSide)

while true do
    if reactor.getWasteFilledPercentage() > wasteLimit then
        reactor.scram()
        print("Too much waste ! ABORT SYSTEM")
    end
    if reactor.getTemperature() > tempLimit then
        reactor.scram()
        print("Not enough coolant ! ABORT SYSTEM")
    end
    sleep(1)
end

--getFuel().amount
--getCoolant().amount