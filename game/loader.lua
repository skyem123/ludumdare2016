local Crystal = require 'crystal'


local loader = {}


function loader.new_level()
	return {
		crystals = {},
		goals = {}
	}
end

function loader.save_crystal(level, ...)
	local crystal = Crystal:new({}, ...)
	table.insert(level.crystals, crystal)
end

function loader.load_level(level, name)
	local data = dofile("levels/" .. name .. ".lua")
	-- reset the level
	level.crystals = {}
	level.goals = {}
	-- load the level
	for _,item in pairs(data) do
	    if item[1] == "crystal" then
	        loader.save_crystal(level, unpack(item, 2))
	    elseif item[1] == "goal" then
			local crystal = Crystal:new_goal({}, unpack(item, 2))
			table.insert(level.crystals, crystal)
			table.insert(level.goals, crystal)
			print(level.crystals)
		end
	end
end

function loader.unload_list()
	loader.list = nil
	loader.position = nil
end

function loader.load_list(name)
	local file = assert(io.open("levels/" .. name .. ".txt"))
	loader.list = {}
	for line in file:lines() do
		table.insert(loader.list, line)
	end
	loader.position = 0
	file:close()
end

function loader.next_level(level)
	if loader.list ~= nil and loader.position ~= nil then
		loader.position = loader.position + 1
		if loader.position <= #loader.list then
			loader.load_level(level, loader.list[loader.position])
		end
	end
end


return loader
