require 'crystal'

screen_displayed = nil
game_paused = false
screen_input = false

linking = false
link_x = 0
link_y = 0
link_id = nil
link_crystal = nil

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








function new_crystal(coords, colour, label, links)
    return {
        ['x'] = coords[1],
        ['y'] = coords[2],
        ['r'] = colour[1],
        ['g'] = colour[2],
        ['b'] = colour[3],
        ['links'] = links or {},
        ['label'] = label or "",
    }
end

-- Here's a list of crystals!
crystals = {
    --new_crystal({42, 42}, {0, 255, 255}, "a", {2}),
    --new_crystal({128, 84}, {255, 0, 255}, "b", {})
}

function save_crystal(coords, colour, links)
    return table.insert(crystals, Crystal:new(coords, colour, links))
end

--save_crystal({256, 256}, {255, 255, 0}, "c", {})
save_crystal({432,  44}, {255,   0,    0}, "1", {})
save_crystal({324,  67}, {  0, 255,    0}, "2", {})
save_crystal({ 42, 563}, {  0,   0,  255}, "3", {})
save_crystal({231, 334}, {255,  255,   0}, "4", {})
save_crystal({ 744, 444}, {  0,  255, 255}, "5", {})
save_crystal({ 444, 223}, {255,    0, 255}, "6", {})


crystal_render_list = {
    -- {r, g, b, x, y, label}
}

function update_crystal_render_list()
    for i,crystal in pairs(crystals) do
        crystal_render_list[i] = {
            crystal.r,
            crystal.g,
            crystal.b,
            crystal.x,
            crystal.y,
            crystal.label,
        }
    end
end

function render_crystals()
    for i,crystal in pairs(crystal_render_list) do
        crystal:draw()
    end
end


link_list = {
    -- {r, g, b, x1, y1, x2, y2}
}

function update_link_list()
    link_list = {}
    local i = 0
    for _,crystal in pairs(crystals) do
        for _,link_dest in pairs(crystal.links) do
            i = i+1
            link_list[i] = {
                crystal.r, crystal.g, crystal.b,
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
    for i,link in pairs(link_list) do
        render_link_position(unpack(link))
    end
end


function update_render_lists()
    update_crystal_render_list()
    update_link_list()
end




function collision_check(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end


function collision_check_crystal(crystal, x,y,w,h)
  local s = crystal.size
  return collision_check(crystal.x - s / 2, crystal.y - s / 2, s, s,  x,y,w,h)
end

function collision_check_all_crystals(x,y,w,h)
    for i,crystal in pairs(crystals) do
        if collision_check_crystal(crystal, x,y,w,h) then
            return i, crystal
        end
    end
    return nil, nill
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

    love.graphics.print("Mouse at: " .. love.mouse.getX() .. ", " .. love.mouse.getY(), 0, 0)
    --if collision_check_crystal(crystals[1],  love.mouse.getX(), love.mouse.getY(), 0, 0) then
        --love.graphics.print("Test!", 0,10)
    --end
    local mouseover_id, mouseover_crystal = collision_check_all_crystals(love.mouse.getX(), love.mouse.getY(), 0, 0)
    if mouseover_id ~= nil then
        love.graphics.print("Mouse Over Crystal ID: " .. tostring(mouseover_id), 0,10)
    end
    if linking then
        love.graphics.print("Linking from: " .. link_x .. ", " .. link_y, 0, 20)
        if link_id then
            love.graphics.print("Linking from ID: " .. link_id, 0, 30)
        end
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

    if not linking and button == 1 then -- start linking
        link_x = x
        link_y = y
        link_id, link_crystal = collision_check_all_crystals(x,y,0,0)
        linking = true
    elseif button == 1 then -- finish linking
        linking = false
        -- TODO
        target_id, target_crystal = collision_check_all_crystals(x,y,0,0)

        local do_not_add = false

        if (link_id ~= nil) and (target_id ~= nil) then
            if target_id == link_id then do_not_add = true end

            for i,link in pairs(crystals[link_id].links) do
                if target_id == link then
                    link_crystal.links[i] = nil
                    do_not_add = true
                    print("gah")
                end
            end

            for i,link in pairs(crystals[target_id].links) do
                if link_id == link then
                    target_crystal.links[i] = nil
                    do_not_add = true
                    print("guh")
                end
            end

            if not do_not_add then
                print("wut")
                table.insert(link_crystal.links, target_id)
            end
            link_y, link_x, link_id, link_crystal, target_id, target_crystal = nil, nil, nil, nil, nil, nil
            update_link_list()
        end
    elseif button == 2 then -- stop linking
        linking = false
    end
end
