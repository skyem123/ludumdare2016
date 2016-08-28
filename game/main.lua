local Crystal = require 'crystal'
local helpers = require 'helpers'
local Link = require 'link'

screen_displayed = nil
game_paused = false
screen_input = false

linking = false
link_x = 0
link_y = 0
link_id = nil
link_crystal = nil

last_dt = 0
total_dt = 0

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

-- Here's a list of crystals!
crystals = {}

function save_crystal(coords, colour, label, links)
  return table.insert(crystals, Crystal:new({}, coords, colour, label, links))
end

function load_level(name)
    level = require("levels/" .. name)
    -- load the level
    for _,item in pairs(level) do
        if item[1] == "crystal" then
            save_crystal(unpack(item, 2))
        end
    end
end


function render_crystals()
  for i,crystal in pairs(crystals) do
    crystal:draw()
  end
end

function find_crystal_from_ID(crystal_list, ID)
    for _,crystal in pairs(crystal_list) do
        if crystal.ID == ID then
            return crystal
        end
    end
end

function render_links()
    for _,crystal in pairs(crystals) do
        crystal:drawlinks()
    end
end


function update_render_lists()
    -- I'm keeping this here incanse there's something
end

function collision_check_all_crystals_ID(x,y,w,h)
  for i,crystal in pairs(crystals) do
    if crystal:collision_check(x,y,w,h) then
      return crystal.ID, crystal
    end
  end
  return nil, nil
end

function collision_check_all_crystals(x,y,w,h)
    local _, crystal = collision_check_all_crystals_ID(x,y,w,h)
    return crystal
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
    helpers.render_link_position({255,255,255}, link_x, link_y, love.mouse.getPosition())
  end

  love.graphics.print("Mouse at: " .. love.mouse.getX() .. ", " .. love.mouse.getY(), 0, 0)
  local mouseover_id, mouseover_crystal = collision_check_all_crystals_ID(love.mouse.getX(), love.mouse.getY(), 0, 0)
  if mouseover_id ~= nil then
    love.graphics.print("Mouse Over Crystal ID: " .. tostring(mouseover_id), 0,10)
  end
  if linking then
    love.graphics.print("Linking from: " .. link_x .. ", " .. link_y, 0, 20)
    if link_id then
        love.graphics.print("Linking from ID: " .. link_id, 0, 30)
    end
  end

  love.graphics.print("DT: " .. last_dt, 0, 40)
  love.graphics.print("Time: " .. total_dt, 0, 50)

end



function love.load()
    load_level("test")
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
    link_id, link_crystal = collision_check_all_crystals_ID(x,y,0,0)
    linking = true
  elseif button == 1 then -- finish linking
    linking = false
    target_crystal = collision_check_all_crystals(x,y,0,0)

    local do_not_add = false



    if (link_crystal ~= nil) and (target_crystal ~= nil) then
      if target_crystal == link_crystal then do_not_add = true end
      for i,link in pairs(link_crystal.links) do
        if target_crystal == link.c2 then
          link_crystal.links[i] = nil
          do_not_add = true
          print("gah")
        end
      end

      for i,link in pairs(target_crystal.links) do
        if link_crystal == link.c2 then
          target_crystal.links[i] = nil
          do_not_add = true
          print("guh")
        end
      end

      if not do_not_add then
        print("wut")
        local collide = false
        local the_link = Link:new(link_crystal, target_crystal)
        for _,crystal in pairs(crystals) do
            for _,link in pairs(crystal.links) do
                if (the_link:collision_check(link)) then
                    collide = true
                end
            end
        end

        if not collide then table.insert(link_crystal.links, Link:new(link_crystal, target_crystal)) end
      end
      --link_y, link_x, link_id, link_crystal, target_id, target_crystal = nil, nil, nil, nil, nil, nil
      update_render_lists()
    end
  elseif button == 2 then -- stop linking
    linking = false
  end
end

function love.update(dt)
   last_dt = dt
   total_dt = total_dt + dt
end
