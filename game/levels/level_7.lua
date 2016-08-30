--[[

{"goal",    0, {420, 150}, {255, 255, 255}, "G", {}, 18, "You need to get 18 from\nthe other crystals..."},
{"crystal", 0, {180, 150}, {  0, 255,   0}, "2", {}, function() return 2 end, "This outputs 2..."},
{"crystal", 4, {340, 250}, {255, 128, 255}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "This multiplies inputs together."},
{"crystal", 0, {340, 325}, {  0, 128,   0}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
{"crystal", 4, {260, 350}, {128,   0, 128}, "+", {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds numbers."},
{"crystal", 4, {200, 150}, {128, 255, 255}, "^", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t^v  end; return t end, "This raises the first value\n by the second value."},
{"crystal", 4, {150, 300}, {128, 128, 128}, "÷", {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t/v  end; return t end, "This divides stuff\n from the first input.\nRemember the order\n you connect things!"},
--]]

return {
	{"crystal", 4, {200, 150}, {128, 0, 128}, "N", {}, function(c, a) return -(a or 0) end, "Negate the first input.\nExample:\n  1 becomes -1"},
	{"crystal", 0, {400, 200}, {255,   0,   0}, "3", {}, function() return 3 end, "Output: 3"},
	{"crystal", 0, {100, 250}, {0, 0, 255}, "0.5", {}, function() return 0.5 end, "Output: 0.5"},
	{"crystal", 4, {300, 300}, {0, 255, 0}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "Multiplies inputs together."},
	{"goal", 0, {100, 350}, {255,255, 255}, "G", {}, 6, "Goal: 6"},

}
