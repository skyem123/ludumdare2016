local screens = {}

local text = {}

local function new_text(name)
	local file = assert(io.open("text/" .. name .. ".txt"))
	local data = file:read("*all")
	file:close()
	return data
end

local function load_text(name)
	text[name] = new_text(name)
end

function screens.welcome()
	love.graphics.print(text["welcome"], 0, 0)
end

function screens.rules()
	love.graphics.print(text.rules, 0, 0)
end

function screens.pause()
	love.graphics.print(
    "Game Paused"
    , 50, 50, 0, 1.5)
    love.graphics.print(
    "Press <ENTER> or 'P' to unpause.\n" ..
    "Press 'R' to display the rules.\n" ..
    "Press 'W' for the welcome screen."
    , 50, 80, 0, 1)
end


load_text("welcome")
load_text("rules")
return screens
