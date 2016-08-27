screen_displayed = nil

function display_welcome()
    love.graphics.print('Hello World!', 400, 300)
end

function love.draw()
    if screen_displayed ~= nil then
        screen_displayed()
        return;
    end
    -- the game should be rendered here.
end

function love.load()
    screen_displayed = display_welcome
end
