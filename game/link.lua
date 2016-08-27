local helpers = require 'helpers'
local Crystal = require 'crystal'

local Link = {
  ['c1'] = Crystal:new(),
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
  local o1 = self.c1:orientation(self.c2, link.c1)
  local o2 = self.c1:orientation(self.c2, link.c2)
  local o3 = link.c1:orientation(link.c2, self.c1)
  local o4 = link.c1:orientation(link.c2, self.c2)

  if (o1 ~= o2 and o3 ~= o4) then
    return true
  end

  if self.c1 == link.c1 or self.c2 == link.c2 then
      return false
  elseif (o1 == 0 and self.c1.onSeg(link.c1, self.c2)) then
    return true
  elseif (o2 == 0 and self.c1.onSeg(link.c2, self.c2)) then
    return true
  elseif (o3 == 0 and link.c1.onSeg(self.c1, link.c2)) then
    return true
  elseif (o4 == 0 and link.c1.onSeg(self.c2, link.c2)) then
    return true
  else
    return false
  end
end

return Link
