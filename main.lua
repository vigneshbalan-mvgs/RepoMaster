package.path = package.path .. ";./?.lua"

-- Main file to interact with the user
local colors = require("colors")
local utils = require("utils")
local panels = require("panels")
local gitstatus = require("gitstatus")

local function editDirectory(directories)
	print("Enter the index of the directory you want to edit:")
	local index = tonumber(io.read())

	if index and directories[index] then
		print("Current directory: " .. directories[index])
		print("Enter the new directory path:")
		local newDir = io.read()
		directories[index] = newDir
		utils.saveDirectories(directories)
		print("Directory updated!")
	else
		print("Invalid index!")
	end
end

local function deleteDirectory(directories)
	print("Enter the index of the directory you want to delete:")
	local index = tonumber(io.read())

	if index and directories[index] then
		table.remove(directories, index)
		utils.saveDirectories(directories)
		print("Directory deleted!")
	else
		print("Invalid index!")
	end
end

local function main()
	local directories = utils.readDirectories() or {}
	local previewText = nil

	while true do
		panels.drawPanels(directories, previewText)

		-- Show options at the bottom of the screen
		-- print(colors.magenta .. string.rep(" ", 80) .. "Choose an option:" .. colors.reset)
		-- print(string.rep(" ", 80) .. "1. Create a new directory")
		-- print(string.rep(" ", 80) .. "2. Edit an existing directory")
		-- print(string.rep(" ", 80) .. "3. Delete an existing directory")
		-- print(string.rep(" ", 80) .. "4. Select a directory")
		-- print(string.rep(" ", 80) .. "5. Exit")

		local choice = io.read() -- Read user choice

		if choice == "1" then
			print("Enter the directory you want to save:")
			local directory = io.read()
			table.insert(directories, directory)
			utils.saveDirectories(directories)
		elseif choice == "2" then
			if #directories == 0 then
				print("No directories to edit.")
			else
				editDirectory(directories)
			end
		elseif choice == "3" then
			if #directories == 0 then
				print("No directories to delete.")
			else
				deleteDirectory(directories)
			end
		elseif choice == "4" then
			if #directories == 0 then
				print("No directories to select.")
			else
				previewText = gitstatus.selectDirectory(directories)
			end
		elseif choice == "5" then
			print("Exiting...")
			break
		else
			print("Invalid choice, please try again.")
		end
	end
end

-- Start the main function
main()
