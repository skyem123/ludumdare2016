local sounds = {}

-- Loads wav files into memory for *short* sound effects.
local function new_sfx(name)
	return love.audio.newSource("sounds/" .. name .. ".wav", "static")
end

local function new_music(name)
	return love.audio.newSource("sounds/" .. name .. ".mp3", "stream")
end

local function load_sounds()
	sounds["select"] = new_sfx("select_crystal")
	sounds["link_finished"] = new_sfx("link_crystals")
	for _,sound in pairs(sounds) do
		sound:setVolume(0.5)
	end
	sounds["track_1"] = new_music("track_01")
	sounds["track_1"]:setVolume(0.1)
end



load_sounds()
return sounds
