return {
	{"goal",    0, {180, 400}, {255, 255, 255}, "G" , {}, 3, "You need to calculate 3\nusing the other cyrstals..."},
	{"crystal", 0, {180, 175}, {255,   0,   0}, "10", {}, function() return 10 end, "This outputs 10..."},
	{"crystal", 4, {340, 325}, {  0, 128,   0}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
	{"crystal", 0, {500, 175}, {  0,   0, 255}, "7" , {}, function() return 7 end, "This outputs 7..."},
}

--[[

{"goal",    0, {420, 150}, {255, 255, 255}, "G", {}, 18, "You need to get 18 from\nthe other crystals..."},
{"crystal", 0, {180, 150}, {  0, 255,   0}, "2", {}, function() return 2 end, "This outputs 2..."},
{"crystal", 4, {340, 250}, {255, 128, 255}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "This multiplies inputs together."},
{"crystal", 0, {340, 325}, {  0, 128,   0}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
{"crystal", 0, {500, 300}, {255,   0,   0}, "5", {}, function() return 5 end, "This outputs 5."},
{"crystal", 4, {260, 350}, {128,   0, 128}, "+", {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds numbers."},
{"crystal", 0, {420, 400}, {  0,   0, 255}, "4", {}, function() return 4 end, "This outputs 4."}

--]]
