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
	{"crystal", 0, {250, 150}, {255,   0,   0}, "3" , {}, function() return 3 end, "Outputs 3."},
	{"goal"   , 0, {350, 150}, {255, 255, 255}, "G" , {}, 1, "Goal!\nCalculate the number 1,\n and bring it here."},
	{"crystal", 4, {150, 200}, {128,   0, 128}, "-" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t-v  end; return t end, "This subtracts stuff from the first input.\nRemember the order you connect things!"},
	{"crystal", 0, {450, 200}, {  0, 255,   0}, "0" , {}, function() return 0 end, "Outputs 0."},
	{"crystal", 4, {250, 250}, { 64, 128,  64}, "÷" , {}, function(c, a,...) local t=a; for _,v in ipairs({...}) do t=t/v  end; return t end, "This divides stuff\n from the first input.\nRemember the order\n you connect things!"},
	{"crystal", 4, {550, 250}, {128, 255, 128}, "×" , {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "Multiplies inputs together."},
	{"crystal", 4, {350, 300}, {200, 128, 200}, "^" , {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t^v  end; return t end, "This raises the first value\n by the second value."},
	{"crystal", 0, {150, 350}, {  0,   0, 255}, "12", {}, function() return 12 end, "Outputs 12."},
	{"crystal", 4, {450, 350}, {255,  64,  64}, "+" , {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds inputs."},
	{"crystal", 0, {650, 350}, {255, 255,   0}, "7" , {}, function() return 7 end, "Outputs 7."},
	{"crystal", 0, {250, 400}, {  0, 255, 255}, "3" , {}, function() return 3 end, "Outputs 3."},
	{"crystal", 0, {550, 400}, {255,   0, 255}, "5" , {}, function() return 5 end, "Outputs 5."},
}
