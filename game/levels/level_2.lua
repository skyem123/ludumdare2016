return {
	{"goal",    0, {420, 150}, {255, 255, 255}, "G", {}, 18, "You need to get 18 from\nthe other crystals..."},
	{"crystal", 0, {180, 150}, {  0, 255,   0}, "2", {}, function() return 2 end, "This outputs 2..."},
	{"crystal", 4, {340, 250}, {255, 128, 255}, "×", {}, function(c, a, ...) local t=(a or 0); for _,v in ipairs({...}) do t=t*v  end; return t end, "This multiplies inputs together."},
	{"crystal", 0, {500, 300}, {255,   0,   0}, "5", {}, function() return 5 end, "This outputs 5."},
	{"crystal", 4, {260, 350}, {128,   0, 128}, "+", {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "This adds numbers."},
	{"crystal", 0, {420, 400}, {  0,   0, 255}, "4", {}, function() return 4 end, "This outputs 4."}

	--{"crystal", 4, {400, 300}, {255, 255,   0}, "+",  {}, function(c, ...) t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "Adds inputs together,\nand outputs the result."},
	--{"crystal", 0, {266, 200}, {255,   0,   0}, "1", {}, function() return 3 end, "Outputs a value.\nIn this case, 3"},
	--{"crystal", 0, {266, 400}, {  0, 255,   0}, "2", {}, function() return 2 end, "Outputs a value.\nIn this case, 2"},
	--{"wall", {128, 128, 128}, 0, 0, 800, 600},
}
