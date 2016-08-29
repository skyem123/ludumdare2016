return {
	{"goal",    0, {533, 300}, {255, 255, 255}, "G",  {}, 3},
	{"crystal", 4, {400, 300}, {255, 255,   0}, "+",  {}, function(c, ...) t=0; for _,v in ipairs({...}) do print(v)  t=t+v  end; return t end},
	{"crystal", 0, {266, 200}, {255,   0,   0}, "1", {}, function() return 1 end},
	{"crystal", 0, {266, 400}, {  0, 255,   0}, "2", {}, function() return 2 end},
}
