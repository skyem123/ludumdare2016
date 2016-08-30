--[[

{"goal",    0, {420, 150}, {255, 255, 255}, "G", {}, 18, "You need to get 18 from\nthe other crystals..."},
{"crystal", 0, {180, 150}, {  0, 255,   0}, "2", {}, function() return 2 end, "This outputs 2..."},
{"crystal", 4, {340, 250}, {255, 128, 255}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "This multiplies inputs together."},
{"crystal", 0, {340, 325}, {  0, 128,   0}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
{"crystal", 4, {260, 350}, {128,   0, 128}, "+", {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds numbers."},
{"crystal", 4, {200, 150}, {128, 255, 255}, "^", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t^v  end; return t end, "This raises the first value\n by the second value."},
--]]

return {
	{"crystal", 4, {200, 150}, {128, 255, 255}, "^", {}, function(c, a, ...) local t=(a or 0); local l={...}; if #l == 0 then return 1 end; for _,v in ipairs(l) do t=t^v  end; return t end, "This raises the first value\n by the second value."},
	{"crystal", 4, {400, 150}, {255,   0, 255}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff\n from the first input.\nThe order of connections\n is important!"},
	{"goal",    0, {150, 250}, {255, 255, 255}, "G", {}, -8, "You need to calculate -8\n from the other crystals..."},
	{"crystal", 0, {450, 250}, {255,   0,   0}, "7", {}, function() return 7 end, "This outputs 7."},
	{"crystal", 0, {250, 350}, {  0, 255,   0}, "3", {}, function() return 3 end, "This outputs 3."},
	{"crystal", 0, {350, 350}, {  0,   0, 255}, "5", {}, function() return 5 end, "This outputs 5."},
}
