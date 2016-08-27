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

function render_pause_screen()
    love.graphics.print(
    "Game Paused"
    , 50, 50, 0, 1.5)
    love.graphics.print(
    "Press <ENTER> to continue."
    , 50, 80, 0, 1)
end

test = false;
x_test = 0;
y_test = 0;

crystal_list = {
    -- {r, g, b, x, y}
    {0,   255, 255, 42, 42, 'a'},
    {255,   0, 255, 128, 84, 'b'}
}

function render_crystal(r, g, b, x, y, label)
    old = {love.graphics.getColor()}

    love.graphics.setColor(r, g, b)
    love.graphics.circle("fill", x, y, 15, 4)

    if label ~= nil then
        love.graphics.setColor(255-r, 255-g, 255-b)
        love.graphics.print(tostring(label), x - 4, y - 7)
    end

    love.graphics.setColor(unpack(old))
end

function render_crystals()
    for i,crystal in ipairs(crystal_list) do
        render_crystal(unpack(crystal))
    end
end


-- TODO: Link from crystal objects?
link_list = {
    {255, 255, 255, 1,2}
}

function render_link(r, g, b, l_1, l_2)
    old = {love.graphics.getColor()}

    love.graphics.setColor(r, g, b)

    local x1 = crystal_list[l_1][4]
    local y1 = crystal_list[l_1][5]
    local x2 = crystal_list[l_2][4]
    local y2 = crystal_list[l_2][5]

    love.graphics.line(x1, y1, x2, y2)

    love.graphics.setColor(unpack(old))
end

function render_links()
    for i,link in ipairs(link_list) do
        render_link(unpack(link))
    end
end

function love.draw()
    if screen_displayed ~= nil then
        game_paused = true
        screen_displayed()
        return
    end
    -- the game should be rendered here.
    --if test then render_crystal(0, 128, 255, x_test, y_test) end
    render_links()
    render_crystals()
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
    elseif key == 'p' then
        screen_displayed = render_pause_screen
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
