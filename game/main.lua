screen_displayed = nil
game_paused = false

function display_welcome()
    love.graphics.print(
    "Welcome to our Ludum Dare game for Ludum Dare 36!\n" ..
    "We haven't named it yet.\n\n" ..
    "This game is about solving a puzzle from some ancient technology.\n" ..
    "Not any old ancient technology, it's unrealistic ancient technolgy found in science fiction!\n" ..
    "Anyway, link the crystals and you'll be fine, okay?\n" ..
    "Good Luck!\n\n\n" ..
    "Press the <ENTER> key to get started. (It exits these screens)"
    , 0, 0)
end

test = false;
x_test = 0;
y_test = 0;

function love.draw()
    if screen_displayed ~= nil then
        game_paused = true
        screen_displayed()
        return
    end
    -- the game should be rendered here.
    if test then love.graphics.circle("fill", x_test, y_test, 10, 4) end
end

function love.load()
    screen_displayed = display_welcome
end

function love.keypressed(key)
    if game_paused then
        if key == 'return' then
            screen_displayed = nil
            game_paused = false
        end

        return
    end
    if key == 'w' then
        screen_displayed = display_welcome
    end
end

function love.mousepressed(x, y, button, istouch)
    if game_paused then return end
    if button == 1 then
        test = true
        x_test = x
        y_test = y
    elseif button == 2 then
        test = false
    end
end
