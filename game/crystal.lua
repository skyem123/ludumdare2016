local Crystal = {
    ['x'] = 0,
    ['y'] = 0,
    ['colour'] = {0, 0, 0},
    ['links'] = {},
    ['label'] = "",
    ['size'] = 40,
    ['ID'] = 0,
}

do

local helpers = require 'helpers'

local nextID = 1

function Crystal:new(o, coords, colour, label, links)
  o = self:internalnew(o or {})
  coords = coords or {}
  o.x = coords[1] or self.x
  o.y = coords[2] or self.y
  o.colour = colour or self.color
  o.links = links or self.links
  o.label = label or self.label
  o.ID = nextID
  nextID = nextID + 1
  return o
end

function Crystal:internalnew(o)
  o = o or {}
  mt = {}
  mt.__index = self
  setmetatable(o, mt)
  return o
end

function Crystal:draw()
  old = {love.graphics.getColor()}

  love.graphics.setColor(unpack(self.colour))
  love.graphics.circle("fill", self.x, self.y, 15, 4)

  if self.label ~= nil then
    love.graphics.setColor(255-self.colour[1], 255-self.colour[2], 255-self.colour[3])
    love.graphics.print(tostring(self.label), self.x - 4, self.y - 7)
  end

  love.graphics.setColor(unpack(old))
end

function Crystal:func(x)
  return x
end

function Crystal:drawlinks()
    for _,link in pairs(self.links) do
      link:draw()
    end
end

function Crystal:collision_check(x,y,w,h)
    local s = self.size
    return helpers.collision_check(self.x - s / 2, self.y - s / 2, s, s,  x,y,w,h)
end

end

return Crystal
