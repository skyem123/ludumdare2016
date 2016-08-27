local helpers = {}

function helpers.collision_check(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function helpers.wrapWithColour(r, g, b, wrap, ...)
	old = {love.graphics.getColor()}
	love.graphics.setColor(r, g, b)
	local data  = { wrap(...) }
	love.graphics.setColor(unpack(old))
	return unpack(data)
end

function helpers.render_link_position(r, g, b, x1, y1, x2, y2)
    helpers.wrapWithColour(r, g, b, love.graphics.line, x1, y1, x2, y2)
end

return helpers
