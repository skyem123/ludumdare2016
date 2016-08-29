local helpers = require 'helpers'
local Crystal = require 'crystal'
local Wave = require 'wave'
numballs = 100

local Link = {
  ['source'] = Crystal:new(),
  ['destination'] = Crystal:new(),
  ['colour'] = {0, 0, 0},
  ['off'] = 0,
  ['wave'] = Wave
}

function Link:new(source, destination, colour, o)
  o = self:internalnew(o or {})
  o.source = source or self.source
  o.destination = destination or self.destination
  o.colour = colour or o.source.colour
  local function crysttopoint(c)
    return point(c.x, c.y)
  end
  o.wave = Wave:new(crysttopoint(o.source), crysttopoint(o.destination), 100, 1)
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

  love.graphics.push()

  local val
  if self.source.value == 0 then
    val = 0.1
  else
    val = self.source.value
  end

  -- self.wave:wave(self.off, val)

  if self.source.value == 0 then
    love.graphics.setColor(100, 100, 100, 100)
  elseif self.source.value > 0 then
    love.graphics.setColor(0, 255, 0, 100)
  else
    love.graphics.setColor(255, 0, 0, 100)
  end

  self.wave:draw()

  love.graphics.pop()

  self.off = self.off + 0.1
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

function Link:calcball(x, y, func)
  local perpangle = self:angle() - math.pi/2

  local dist = x ^ 2 + y ^ 2
  local h = func(dist + self.off)
  return {x + math.cos(perpangle) * h, y + math.sin(perpangle) * h}
end

function Link:angle()
  return math.atan(self.destination.y - self.source.y / self.destination.x - self.source.x) + math.pi/2
end

function Link:slope()
  if (self.source.x == self.destination.x) then
    -- hack to make the slope really high, infinity in practice
    -- Blame no good way to represent INF for calculations
    return 100000000000000
  else
    return (self.destination.y - self.source.y)/(self.destination.x - self.source.x)
  end
end

return Link
