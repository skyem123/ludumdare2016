screen_displayed = nil
game_paused = false
screen_input = false

linking = false
link_x = 0
link_y = 0

function display_welcome()
    love.graphics.print(
    "Welcome to our Ludum Dare game for Ludum Dare 36!\n" ..
    "We haven't named it yet.\n\n" ..
    "This game is about solving a puzzle from some ancient technology.\n" ..
    "Not any old ancient technology, it's unrealistic ancient technolgy found in science fiction!\n" ..
    "Anyway, link the crystals and you'll be fine, okay?\n" ..
    "Good Luck!\n\n\n" ..
    "Press the <ENTER> key to get started. (It exits these screens)\n" ..
    "Press the 'R' key to display the rules.\n" ..
    "Press the 'P' key to pause.\n" ..
    "Press the 'W' key for this welcome screen."
    , 0, 0)
end

function render_pause_screen()
    love.graphics.print(
    "Game Paused"
    , 50, 50, 0, 1.5)
    love.graphics.print(
    "Press <ENTER> or 'P' to unpause.\n" ..
    "Press 'R' to display the rules.\n" ..
    "Press 'W' for the welcome screen."
    , 50, 80, 0, 1)
end

test = false;
x_test = 0;
y_test = 0;








function new_crystal(coords, colour, links)
    return {
        ['x'] = coords[1],
        ['y'] = coords[2],
        ['r'] = colour[1],
        ['g'] = colour[2],
        ['b'] = colour[3],
        ['links'] = links or {}
    }
end

-- Here's a list of crystals!
crystals = {
    new_crystal({42, 42}, {0, 255, 255}, {2}),
    new_crystal({128, 84}, {255, 0, 255}, {})
}

function save_crystal(coords, colour, links)
    return table.insert(crystals, new_crystal(coords, colour, links))
end

save_crystal({256, 256}, {255, 255, 0}, {})




crystal_render_list = {
    -- {r, g, b, x, y}
}

function update_crystal_render_list()
    for i,crystal in ipairs(crystals) do
        crystal_render_list[i] = {
            crystal.r,
            crystal.g,
            crystal.b,
            crystal.x,
            crystal.y
        }
    end
end

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
    for i,crystal in ipairs(crystal_render_list) do
        render_crystal(unpack(crystal))
    end
end


link_list = {
    -- {r, g, b, x1, y1, x2, y2}
}

function update_link_list()
    for i,crystal in ipairs(crystals) do
        for _,link_dest in ipairs(crystal.links) do
            link_list[i] = {
                255, 255, 255,
                crystal.x, crystal.y,
                crystals[link_dest].x, crystals[link_dest].y
            }
        end
    end
end

function render_link_position(r, g, b, x1, y1, x2, y2)
    old = {love.graphics.getColor()}

    love.graphics.setColor(r, g, b)

    love.graphics.line(x1, y1, x2, y2)

    love.graphics.setColor(unpack(old))
end

function old_render_link_crystal(r, g, b, l_1, l_2)
    local x1 = crystal_render_list[l_1][4]
    local y1 = crystal_render_list[l_1][5]
    local x2 = crystal_render_list[l_2][4]
    local y2 = crystal_render_list[l_2][5]

    render_link_position(r, g, b, x1, y1, x2, y2)
end

function render_links()
    for i,link in ipairs(link_list) do
        render_link_position(unpack(link))
    end
end


function update_render_lists()
    update_crystal_render_list()
    update_link_list()
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

    -- render the links you are creating
    if linking then
        render_link_position(255,255,255, link_x, link_y, love.mouse.getPosition())
    end
end

function love.load()
    screen_displayed = display_welcome
    update_render_lists()
end

function love.keypressed(key)
    if screen_input then
        return
    end

    if game_paused then
        if key == 'return' then
            screen_displayed = nil
            game_paused = false
        end
    end
    if key == 'w' then
        screen_displayed = display_welcome
    elseif key == 'p' then
        if screen_displayed == render_pause_screen then
            screen_displayed = nil
            game_paused = false
        else
            screen_displayed = render_pause_screen
        end
    end
    if key == 'u' then
        update_render_lists()
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

    if not linking then
        link_x = x
        link_y = y
        linking = true
    else
        linking = false
    end
end
