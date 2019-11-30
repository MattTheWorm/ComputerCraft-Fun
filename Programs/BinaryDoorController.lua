--[[
Notes:
 *Pistons (outputs) are in direct binary form. 
	Such that if you have 8 outputs --> 00000000 each piston is a 0, but it's just direct binary
	If the rightmost piston is on.. 00000001 The number value is 1
	If the leftmost value is on.. 10000000 The number value for this set is 128
 *Pistons 



]]--
--
-- Vars
--
local pistonArray = {}
local maxNumber = 10 --Max number of pistons 
local startPoint --Point in which pistons start to split from
local x1, x2
local sleepTime, waitTime = 0.07, 4

--
-- Func
--
local function stateToBinary(stateArray, mode)
  local arrayString = ""

  for i, v in pairs(stateArray) do
    arrayString = arrayString .. v

  end
  
  return arrayString

end

local function printState(stateArray)
  io.write("Current Values (Array) [")
  for i, v in pairs(stateArray) do
    io.write(v)

  end

  io.write("]\nBinary: ", stateToBinary(stateArray), " Value: ", tonumber(stateToBinary(stateArray), "2"), "\n")

end

local function outputToPistons(binaryVal)
	binaryVal = string.reverse(binaryVal)
	printState(pistonArray)
	rs.setBundledOutput("back", tonumber(binaryVal, "2"))
	print("Piston out. Value sent: ", tonumber(binaryVal, "2"), string.format(" Binary Value: %s", binaryVal))
	
end

--
-- Array Init (based on maxNumber)
--
for i = 1, maxNumber do
  pistonArray[i] = 0
  --print("Piston position "  .. i .. " ready.")

end

--
-- Main
--
print("Enter the starting point. (From 0 to " .. maxNumber .. ")")
io.write("Input: ")
startPoint = tonumber(io.read())
x1, x2 = startPoint, startPoint
assert(startPoint < maxNumber or startPoint < 1, "Chosen starting point is greater than the maximum number of pistons or less than 1!\nExiting program.")
sleep(waitTime)
pistonArray[startPoint] = 1
print(x1, x2)
outputToPistons(stateToBinary(pistonArray))
sleep(sleepTime)
for i = 1, maxNumber do
  
  
  if x1 ~= 1 then
    x1 = x1 - 1
    pistonArray[x1] = 1

  end

  if x2 ~= maxNumber then
    x2 = x2 + 1
    pistonArray[x2] = 1

  end

  if x2 == maxNumber and x1 == 1 then
    break
	
  end
  
  print(x1, x2)
  outputToPistons(stateToBinary(pistonArray))
  sleep(sleepTime)
  
end

sleep(sleepTime)
print(x1, x2)
outputToPistons(stateToBinary(pistonArray))
sleep(waitTime)
for i = 1, maxNumber do
  
  
  if x1 ~= startPoint then
    x1 = x1 + 1
    pistonArray[x1] = 0

  end

  if x2 ~= startPoint then
    x2 = x2 - 1
    pistonArray[x2] = 0

  end

  if x2 == startPoint and x1 == startPoint then
    break
	
  end
  
  print(x1, x2)
  outputToPistons(stateToBinary(pistonArray))
  sleep(sleepTime)
  
end

sleep(sleepTime)
print(x1, x2)
outputToPistons(stateToBinary(pistonArray))

print("Complete")