local socket = require("socket")

local function readKey()
	local stdin = io.stdin
	stdin:setvbuf("no") -- Set no buffering for stdin
	local key = stdin:read(1) -- Read one character
	return key
end

local function navigateAndPrint()
	print("Press 'q' to quit, 'h' 'j' 'k' 'l' to move.")

	while true do
		local key = readKey()

		if key == "q" then
			print("Exiting...")
			break
		elseif key == "h" then
			print("Move Left")
		elseif key == "j" then
			print("Move Down")
		elseif key == "k" then
			print("Move Up")
		elseif key == "l" then
			print("Move Right")
		else
			print("Unknown command")
		end
	end
end

navigateAndPrint()
