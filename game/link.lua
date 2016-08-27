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
  return false -- TODO
end

function Link:solve_line()
  local this = self
  return function (x)
    return this.slope() * (x - this.c1.x) + this.c1.y1
  end
end

function Link:same_line(link)
  local function same_coord(a, b)
    return a.x == b.x and a.y == b.y
  end
  return same_coord(self.c1, link.c1) and same_coord(self.c2, link.c2)
end

function Link:para_check(link)
  return self.slope() == link.slope()
end

function Link:slope()
  if (self.c1.x < self.c2.x) then
    start = self.c1
    target = self.c2
  elseif (self.c1.x > self.c2.x) then
    start = self.c2
    target = self.c1
  else
    return nil
  end
  return ((target.y - start.y) / (target.x - start.y))
end

return Link
