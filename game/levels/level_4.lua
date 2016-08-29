--[[

{"goal",    0, {420, 150}, {255, 255, 255}, "G", {}, 18, "You need to get 18 from\nthe other crystals..."},
{"crystal", 0, {180, 150}, {  0, 255,   0}, "2", {}, function() return 2 end, "This outputs 2..."},
{"crystal", 4, {340, 250}, {255, 128, 255}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "This multiplies inputs together."},
{"crystal", 0, {340, 325}, {  0, 128,   0}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
{"crystal", 0, {500, 300}, {255,   0,   0}, "5", {}, function() return 5 end, "This outputs 5."},
{"crystal", 4, {260, 350}, {128,   0, 128}, "+", {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds numbers."},
{"crystal", 0, {420, 400}, {  0,   0, 255}, "4", {}, function() return 4 end, "This outputs 4."}

--]]

return {
	{"crystal", 0, {200, 142}, {255,   0,   0}, "2", {}, function() return 2 end, "This outputs 2."},
	{"crystal", 0, {350, 142}, {  0, 128,   0}, "5", {}, function() return 5 end, "This outputs 5."},
	{"crystal", 0, {500, 142}, {  0, 128,   0}, "5", {}, function() return 5 end, "This outputs 5."},
	{"crystal", 4, {200, 226}, {255,   0, 255}, "÷", {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t/v  end; return t end, "This divides stuff\n from the first input.\nThe order of connections\n is important!"},
	{"crystal", 4, {300, 226}, {255, 255,   0}, "-", {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
	{"crystal", 4, {450, 226}, {  0, 255,   0}, "+", {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds numbers."},
	{"crystal", 0, {150, 310}, {  0,   0, 255}, "4", {}, function() return 4 end, "This outputs 4."},
	{"crystal", 4, {350, 310}, {128, 255, 255}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "This multiplies inputs together."},
	{"crystal", 0, {200, 394}, {  0, 255, 128}, "3", {}, function() return 3 end, "This outputs 3."},
	{"goal",    0, {450, 394}, {255, 255, 255}, "G", {}, 6, "You need to calculate 6."}

}
