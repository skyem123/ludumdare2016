local Crystal = {
    ['x'] = 0,
    ['y'] = 0,
    ['r'] = 0,
    ['g'] = 0,
    ['b'] = 0,
    ['links'] = {},
    ['label'] = "",
    ['size'] = 40
}

do

function Crystal:new(o, coords, colour, label, links)
  o = self:internalnew(o)
  o.x = coords[1] or self.x
  o.y = coords[2] or self.y
  o.r = colour[1] or self.r
  o.g = colour[2] or self.g
  o.b = colour[3] or self.b
  o.links = links or self.links
  o.label = label or self.label
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

  love.graphics.setColor(self.r, self.g, self.b)
  love.graphics.circle("fill", self.x, self.y, 15, 4)

  if self.label ~= nil then
    love.graphics.setColor(255-self.r, 255-self.g, 255-self.b)
    love.graphics.print(tostring(self.label), self.x - 4, self.y - 7)
  end

  love.graphics.setColor(unpack(old))
end

function Crystal:func(x)
  return x
end

function Crystal:drawlinks()

end

function Crystal:collision_check(x,y,w,h)
 -- TODO
end

end

return Crystal
