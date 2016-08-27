local helpers = require 'helpers'
local Crystal = require 'crystal'

local Link = {
  ['c1'] = Crystal:new({}, {100, 100}),
  ['c2'] = Crystal:new(),
  ['colour'] = {0, 0, 0}
}

function Link:new(c1, c2, colour, o)
  o = self:internalnew(o or {})
  o.c1 = c1 or self.c1
  o.c2 = c2 or self.c2
  o.colour = colour or o.c1.colour
  return o
end

function Link:internalnew(o)
  o = o or {}
  mt = {}
  mt.__index = self
  setmetatable(o, mt)
  return o
end


function Link:draw()
  helpers.render_link_position(self.colour, self.c1.x, self.c1.y, self.c2.x, self.c2.y)
end

function Link:collision_check(link)
  return false -- TODO
end

return Link
