local helpers = {}

function helpers.collision_check(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function helpers.wrapWithColour(colour, wrap, ...)
	old = {love.graphics.getColor()}
	love.graphics.setColor(unpack(colour))
	local data  = { wrap(...) }
	love.graphics.setColor(unpack(old))
	return unpack(data)
end

function helpers.render_link_position(colour, x1, y1, x2, y2)
    helpers.wrapWithColour(colour, love.graphics.line, x1, y1, x2, y2)
end

function helpers.range(from, to, step)
  step = step or 1
  return function(_, lastvalue)
    local nextvalue = lastvalue + step
    if step > 0 and nextvalue <= to or step < 0 and nextvalue >= to or
       step == 0
    then
      return nextvalue
    end
  end, nil, from - step
end

return helpers
