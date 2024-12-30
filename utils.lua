local function readDirectories()
	local file = io.open("directories.txt", "r")
	local directories = {}
	if file then
		for line in file:lines() do
			table.insert(directories, line)
		end
		file:close()
	end
	return directories
end

local function saveDirectories(directories)
	local file = io.open("directories.txt", "w")
	if file then
		for _, dir in ipairs(directories) do
			file:write(dir .. "\n")
		end
		file:close()
	end
end

return {
	readDirectories = readDirectories,
	saveDirectories = saveDirectories,
}
