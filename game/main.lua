screen_displayed = nil

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

function love.keypressed(key)
    if screen_displayed ~= nil then
        if key == 'return' then
            screen_displayed = nil;
        end
    end
end
