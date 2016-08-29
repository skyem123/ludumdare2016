local Crystal = {
    ['x'] = 0,
    ['y'] = 0,
    ['colour'] = {0, 0, 0},
    ['linked_from'] = {},
    ['label'] = "",
    ['size'] = 40,
    ['ID'] = 0,
    ['value'] = 0,
    ['operation'] = function(current, a, b) return current end,
    ['inputs'] = {},
    ['style'] = 4,
}

do

local helpers = require 'helpers'

local nextID = 1

function Crystal:new(o, style, coords, colour, label, linked_from, operation, tooltip)
  o = self:internalnew(o or {})
  coords = coords or {}
  o.x = coords[1] or self.x
  o.y = coords[2] or self.y
  o.colour = colour or self.color
  o.linked_from = linked_from or self.linked_from
  o.label = label or self.label
  o.ID = nextID
  o.operation = operation or self.operation
  o.style = style or self.style
  o.tooltip = tooltip
  nextID = nextID + 1
  return o
end

function Crystal:new_goal(o, style, coords, colour, label, linked_from, goal, tooltip)
    crystal = Crystal.new(self, o, style, coords, colour, label, linked_from, function() return nil end, tooltip)
    crystal.goal = goal
    return crystal
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
  if self.style == 0 then
    love.graphics.circle("fill", self.x, self.y, 15, 50)
  else
    love.graphics.circle("fill", self.x, self.y, 15, self.style)
  end

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
    for _,link in pairs(self.linked_from) do
      link:draw()
    end
end

function Crystal:collision_check(x,y,w,h)
    local s = self.size
    return helpers.collision_check(self.x - s / 2, self.y - s / 2, s, s,  x,y,w,h)
end

function Crystal:orientation(q, r)
  local val = (q.y - self.y) * (r.x - q.x) -
              (q.x - self.x) * (r.y - q.y)
  if val == 0 then
    return 0
  elseif (val > 0) then
    return 1
  else
    return 2
  end
end

function Crystal:onSeg(q, r)
  -- TODO FIXME
  if r == nil then return false end
  return q.x <= math.max(self.x, r.x) and q.x >= math.min(self.x, r.x) and
         q.y <= math.max(self.y, r.y) and q.y >= math.min(self.y, r.y)
end

end

return Crystal
