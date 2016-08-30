return {
	{"goal",    0, {433, 300}, {255, 255, 255}, "G",  {}, 5, "Checks it's input.\nif input equals goal,\nyou pass.\ngoal is 5."},
	{"crystal", 4, {300, 300}, {255, 255,   0}, "+",  {}, function(c, ...) local t=0; for _,v in ipairs({...}) do t=t+v  end; return t end, "Adds inputs together,\nand outputs the result.", ""},
	{"crystal", 0, {166, 200}, {255,   0,   0}, "1", {}, function() return 3 end, "Outputs a value.\nIn this case, 3"},
	{"crystal", 0, {166, 400}, {  0, 255,   0}, "2", {}, function() return 2 end, "Outputs a value.\nIn this case, 2"},
	--{"wall", {128, 128, 128}, 0, 0, 800, 600},
}
