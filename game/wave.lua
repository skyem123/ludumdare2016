local Wave = {
  points = {},
  length = 0,
  unit = 0,
  angle = 0,
  p1 = {0, 0},
  p2 = {0, 0},
}

function Wave:new(p1, p2, n, speed)
  p1.x, p2.x = swap_if(p1.x > p2.x, p1.x, p2.x)
  p1.x, p2.x = swap_if(p1.x > p2.x, p1.x, p2.x)
  local delta = point(p2.x - p1.x, p2.y - p1.y)
  local length = math.sqrt(square(delta.x) + square(delta.y))

  return self:internalnew({
    points = get_points(p1, p2, n, length),
    length = length,
    unit = length / n,
    angle = angle_to(p1, p2),
    p1 = p1,
    p2 = p2,
  })
end

function Wave:internalnew(o)
  o = o or {}
  mt = {}
  mt.__index = self
  setmetatable(o, mt)
  return o
end

function point(x, y) return {
  ['x'] = x,
  ['y'] = y
}
end

function square(n) return n*n end

function swap_if(cond, a, b)
  if cond then
    return b, a
  else
    return a, b
  end
end

function angle_to(p1, p2)
  delta = point(p2.x - p1.x, p2.y - p1.y)
  return math.atan2(delta.y, delta.x)
end

function get_points(p1, p2, n, length)
  local delta = point(p2.x - p1.x, p2.y - p1.y)
  local unit = length / n
  local angle = angle_to(p1, p2)

  print(unit)

  local points = {}
  for i = 1, n do
    table.insert(points, point((unit*n) + p1.x, p1.y))
  end
  return points
end

function Wave:wave(dt, val)
  for _, pt in pairs(self.points) do
    pt.y = pt.y + math.sin(pt.x + dt) * val
  end
end

function Wave:draw()
  for _, pt in pairs(self.points) do
    -- love.graphics.translate(self.p1.x, self.p1.y)
    -- love.graphics.rotate(self.angle)
    love.graphics.ellipse("fill", pt.x, pt.y, 2)
  end
end

return Wave
