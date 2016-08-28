local helpers = require 'helpers'
local Crystal = require 'crystal'

local Link = {
  ['source'] = Crystal:new(),
  ['destination'] = Crystal:new(),
  ['colour'] = {0, 0, 0}
}

function Link:new(source, destination, colour, o)
  o = self:internalnew(o or {})
  o.source = source or self.source
  o.destination = destination or self.destination
  o.colour = colour or o.source.colour
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
  helpers.render_link_position(self.colour, self.source.x, self.source.y, self.destination.x, self.destination.y)
end

function Link:collision_check(link)
  local o1 = self.source:orientation(self.destination, link.source)
  local o2 = self.source:orientation(self.destination, link.destination)
  local o3 = link.source:orientation(link.destination, self.source)
  local o4 = link.source:orientation(link.destination, self.destination)

  local function orall(a, b, c, d)
    return a == c or a == d or b == c or b == d;
  end


  if orall(self.source, self.destination, link.source, link.destination) then
    return false
  end

  if (o1 ~= o2 and o3 ~= o4) then
    return true
  end

  if (o1 == 0 and self.source.onSeg(link.source, self.destination)) then
    return true
  elseif (o2 == 0 and self.source.onSeg(link.destination, self.destination)) then
    return true
  elseif (o3 == 0 and link.source.onSeg(self.source, link.destination)) then
    return true
  elseif (o4 == 0 and link.source.onSeg(self.destination, link.destination)) then
    return true
  else
    return false
  end
end

return Link
