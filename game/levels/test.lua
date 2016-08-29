return {
	{"crystal", 4, {432,  167}, {255,   0,    0}, "+1", {}, function(c, a) return (a or 0)+1 end},
	{"crystal", 4, {324,  67}, {  0, 255,    0}, " ",  {}, function(c, a) return a end},
	{"crystal", 4, { 42, 500}, {  0,   0,  255}, "*2", {}, function(c, a) return (a or 0)*2 end},
	{"crystal", 4, {231, 334}, {255,  255,   0}, " ",  {}, function(c, a) return a end},
	{"crystal", 4, {744, 444}, {  0,  255, 255}, "+",  {}, function(c, ...) t=0; for _,v in ipairs({...}) do print(v)  t=t+v  end; return t end},
	--{"crystal", 4, {744, 444}, {  0,  255, 255}, "+",  {}, function(c, a, b) print(a, b)return (a or 0)+(b or 0) end},
	{"crystal", 0, {444, 223}, {255,    0, 255}, "1",  {}, function(c, a) return 1 end},
	{"goal",    0, {780,  20}, {255,  255, 255}, "G",  {}, 4},
	{"goal",    0, {300, 160}, {255,  255, 255}, "G",  {}, 1},
}
