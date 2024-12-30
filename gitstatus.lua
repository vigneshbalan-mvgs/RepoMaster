-- Git status functions
local function selectDirectory(directories)
	print("Enter the index of the directory you want to select:")
	local index = tonumber(io.read())

	if index and directories[index] then
		-- Execute git status in the selected directory
		local command = 'cd "' .. directories[index] .. '" && git status'
		local handle = io.popen(command)
		local result = handle:read("*a")
		handle:close()

		-- Return the result for displaying in the preview panel
		return result
	else
		print("Invalid index!")
		return "Invalid directory selection."
	end
end

local function gitDiff(directory)
	local command = 'cd "' .. directory .. '" && git diff'
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	return result
end

return {
	selectDirectory = selectDirectory,
	gitDiff = gitDiff,
}
