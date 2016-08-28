local helpers = require 'helpers'
local Crystal = require 'crystal'
numballs = 100

local Link = {
  ['source'] = Crystal:new(),
  ['destination'] = Crystal:new(),
  ['colour'] = {0, 0, 0},
  ['off'] = 0
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
  self:drawwave()
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

function Link:drawwave()
  love.graphics.push()

  local dx = self.destination.x - self.source.x
  local dy = self.destination.y - self.source.y
  local a1 = -self:angle()
  local a2 = a1 + math.pi
  love.graphics.translate(self.source.x, self.source.y)
  love.graphics.rotate(-self:angle())

  local amp
  if (self.source.value == 0) then
    amp = 0.1
  else
    amp = self.source.value
  end
  love.graphics.ellipse("line", dx, dy, 20)

  -- Color of wave, used t
  if (self.source.value == 0) then
    love.graphics.setColor(200, 200, 200, 100)
  elseif (self.source.value > 0) then
    love.graphics.setColor(0, 255, 0, 100)
  else
    love.graphics.setColor(255, 0, 0, 100)
  end

  for vx in helpers.range(0, dx, dx / numballs) do
    local vy = (vx / math.cos(self:angle()))


    local coords = self:calcball(vx, vy, function (x)
      return amp * math.sin(x)
    end)
    love.graphics.rotate(-math.pi/2 - self:angle() + math.pi/2)
    love.graphics.ellipse("fill", coords[1], coords[2], 2)
    love.graphics.rotate(math.pi/2 + self:angle() - math.pi/2)
  end

  self.off = self.off + 0.1
  if self.off == math.pi then self.off = 0 end
  love.graphics.pop()
end

function Link:calcball(x, y, func)
  local perpangle = self:angle()
  local dist = (self.source.x - x) ^ 2 + (self.source.y - y) ^ 2
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
