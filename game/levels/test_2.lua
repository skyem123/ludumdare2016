return {
	{"goal",    0, {533, 300}, {255, 255, 255}, "G",  {}, 3, "Checks it's input.\nif input equals goal,\nyou pass.\ngoal is 3."},
	{"crystal", 4, {400, 300}, {255, 255,   0}, "+",  {}, function(c, ...) t=0; for _,v in ipairs({...}) do print(v)  t=t+v  end; return t end, "Adds inputs together,\nand outputs the result."},
	{"crystal", 0, {266, 200}, {255,   0,   0}, "1", {}, function() return 1 end, "Outputs a value.\nIn this case, 1"},
	{"crystal", 0, {266, 400}, {  0, 255,   0}, "2", {}, function() return 2 end, "Outputs a value.\nIn this case, 2"},
}
