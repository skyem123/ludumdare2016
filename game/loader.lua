local Crystal = require 'crystal'


local loader = {}


function loader.new_level()
	return {
		crystals = {}
	}
end

function loader.save_crystal(level, ...)
	table.insert(level.crystals, Crystal:new({}, ...))
end

function loader.load_level(level, name)
	local data = require("levels/" .. name)
	-- load the level
	for _,item in pairs(data) do
	    if item[1] == "crystal" then
	        loader.save_crystal(level, unpack(item, 2))
	    end
	end
end


return loader
