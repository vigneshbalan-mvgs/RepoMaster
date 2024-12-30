local colors = require("colors")

-- Function to clear the screen (for UNIX-based systems)
local function clearScreen()
	os.execute("clear")
end

-- Function to get the terminal's width and height
local function getTerminalSize()
	local handle = io.popen("stty size", "r")
	local result = handle:read("*a")
	handle:close()

	-- Return width and height as integers
	local rows, columns = result:match("(%d+) (%d+)")
	return tonumber(columns), tonumber(rows)
end

-- Function to draw the panels based on terminal size
local function drawPanels(directories, previewText)
	clearScreen()

	-- Get the terminal width and height
	local terminalWidth, terminalHeight = getTerminalSize()

	-- Calculate panel width and height
	local panelWidth = math.floor(terminalWidth / 2) -- Half of terminal width
	local panelHeight = math.floor(terminalHeight / 2) -- Half of terminal height

	-- Left panel (Options Menu)
	local leftPanel = {}

	table.insert(leftPanel, colors.green .. string.rep(" ", panelWidth)) -- Top padding for the left panel
	table.insert(leftPanel, colors.magenta .. "Options:")
	table.insert(leftPanel, colors.green .. "1. Create a new directory")
	table.insert(leftPanel, colors.green .. "2. Edit an existing directory")
	table.insert(leftPanel, colors.green .. "3. Delete an existing directory")
	table.insert(leftPanel, colors.green .. "4. Select a directory")
	table.insert(leftPanel, colors.green .. "5. Exit")
	table.insert(leftPanel, colors.magenta .. "File")

	-- Add directory list or "No directories saved yet." if there are less than panelHeight - 8 directories
	for i = 1, panelHeight - 8 do
		table.insert(
			leftPanel,
			colors.green .. string.format("%d. %s", i, directories[i] or "No directories saved yet.")
		)
	end

	-- Right panel (Preview - Git Status)
	local rightPanel = {}
	table.insert(rightPanel, colors.cyan .. "Preview (Git Status):" .. colors.reset)
	table.insert(rightPanel, previewText or "No preview available.")

	-- Padding if the preview content is less than the required height
	for i = #rightPanel + 1, panelHeight do
		table.insert(rightPanel, "") -- Padding for the right panel
	end

	-- Print both panels side by side
	for i = 1, panelHeight do
		local leftLine = leftPanel[i] or ""
		local rightLine = rightPanel[i] or ""

		-- Ensure both panels align, using string.rep for padding
		local padding = string.rep(" ", panelWidth - #leftLine)
		print(leftLine .. padding .. rightLine)
	end
end

return {
	drawPanels = drawPanels,
}
