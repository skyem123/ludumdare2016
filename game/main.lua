local Crystal = require 'crystal'
local helpers = require 'helpers'
local Link = require 'link'
local audio = require 'audio'
local loader = require 'loader'
local screens = require 'screens'

no_sfx = false

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

goal_reached = false

test = false;
x_test = 0;
y_test = 0;

level = loader.new_level()



function render_tooltip(text, x, y)
    love.graphics.print(text, x,y, nil, 2, nil, -10, 15)
end




check_goals_time = total_dt
function check_goals()
    local reached = true
    for _,goal in pairs(level.goals) do
        local this_reached = false
        for _,input in pairs(goal.inputs) do
            this_reached = this_reached or input == goal.goal
        end
        reached = reached and this_reached
    end
    local new_time = total_dt

    if not reached then
        --print("tick")
        check_goals_time = new_time
    elseif (new_time - check_goals_time) >= 1 then
        --print("hmm")
        return true
    --else print("ugh " .. tonumber(check_goals_time - new_time))
    end

    return false
end

wall_link_list = {}

function render_walls()
    --[[
    for _,wall in pairs(wall_list) do
        helpers.render_link_position(unpack(wall))
    end--]]
    for _,link in pairs(wall_link_list) do
        link:draw()
    end
end


function render_crystals()
  for i,crystal in pairs(level.crystals) do
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
    for _,crystal in pairs(level.crystals) do
        crystal:drawlinks()
    end
end


function update_render_lists()
    -- Not technically for a render list, but close enough!
    for i,wall in pairs(level.walls) do
        local link = Link:new(Crystal:new(nil, nil, {wall[2], wall[3]}), Crystal:new(nil, nil, {wall[4], wall[5]}), wall[1])
        wall_link_list[i] = link
    end
end

function collision_check_all_crystals_ID(x,y,w,h)
  for i,crystal in pairs(level.crystals) do
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


function draw_debug_info()
    love.graphics.print("Mouse at: " .. love.mouse.getX() .. ", " .. love.mouse.getY(), 0, 0)
    local mouseover_id, mouseover_crystal = collision_check_all_crystals_ID(love.mouse.getX(), love.mouse.getY(), 0, 0)
    if mouseover_id ~= nil then
      love.graphics.print("Mouse Over Crystal ID: " .. tostring(mouseover_id), 0,10)
      love.graphics.print("Mouse over Crystal value: " .. tostring(mouseover_crystal.value), 0, 60)
      if mouseover_crystal.goal ~= nil then
          love.graphics.print("Mouse over crystal goal: " .. tostring(mouseover_crystal.goal), 0, 100)
          love.graphics.print("Mouse over crystal goal complete? " ..  tostring(mouseover_crystal.completed or "false"), 0, 120)
      end
      love.graphics.print("Mouse over crystal inputs: " .. table.concat(mouseover_crystal.inputs, ", "), 0, 110)
    end
    if linking then
      love.graphics.print("Linking from: " .. link_x .. ", " .. link_y, 0, 20)
      if link_id then
          love.graphics.print("Linking from ID: " .. link_id, 0, 30)
      end
    end

    love.graphics.print("DT: " .. love.timer.getDelta(), 0, 40)
    love.graphics.print("Average DT: " .. love.timer.getAverageDelta(), 0, 80)
    love.graphics.print("Time (excluding pause): " .. total_dt, 0, 50)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 70)
    love.graphics.print("Level goal reached? " .. tostring(goal_reached or "false"), 0, 90)
end

function love.draw()
  if screen_displayed ~= nil then
    game_paused = true
    screen_displayed()
    return
  end
  -- the game should be rendered here.

  if goal_reached then
      love.graphics.print("Press <ENTER> to load the next level...", 10, 550, 0, 3)
  else
      love.graphics.print("Press 'P' to pause the game and get help", 5, 550, 0, 3)
  end

  --if test then render_crystal(0, 128, 255, x_test, y_test) end
  render_links()
  render_crystals()
  render_walls()

  -- render the links you are creating
  if linking then
    helpers.render_link_position({255,255,255}, link_x, link_y, love.mouse.getPosition())
  end

  local mouseover_crystal = collision_check_all_crystals(love.mouse.getX(), love.mouse.getY(), 0, 0)
  if mouseover_crystal then
      if mouseover_crystal.tooltip ~= nil then
          render_tooltip(mouseover_crystal.tooltip, love.mouse.getPosition())
      elseif mouseover_crystal.goal ~= nil then
          render_tooltip("Goal: " .. tonumber(mouseover_crystal.goal), love.mouse.getPosition())
      end
  end

  draw_debug_info()
end



function love.load()
    --loader.load_level(level, "test")
    loader.load_list("list")
    loader.next_level(level)
    screen_displayed = screens.welcome
    update_render_lists()
    audio.track_1:play()
    audio.track_1:setLooping(true)
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
end -- TODO CHECK FOR LEVEL END AND ENTER KEY TO LOAD NEXT LEVEL
  if key == 'w' then
    screen_displayed = screens.welcome
  elseif key == 'h' then
    screen_displayed = screens.rules
  elseif key == 'c' then
    screen_displayed = screens.credits
  elseif key == 'p' then
    if screen_displayed == screens.pause then
      screen_displayed = nil
      game_paused = false
    else
      screen_displayed = screens.pause
    end
  end

  if key == 'return' and goal_reached then
    loader.next_level(level)
  end

  if key == 'u' then
      update_render_lists()
  end

  if key == 'm' then
      if audio["track_1"]:isPlaying() then
          audio["track_1"]:pause()
      else
          audio["track_1"]:play()
      end
  elseif key == 's' then
      no_sfx = not no_sfx
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
    if link_crystal ~= nil and not no_sfx then
        audio['select']:stop()
        audio['select']:play()
    end
  elseif button == 1 then -- finish linking
    linking = false
    target_crystal = collision_check_all_crystals(x,y,0,0)

    local do_not_add = false



    if (link_crystal ~= nil) and (target_crystal ~= nil) then
      if target_crystal == link_crystal then do_not_add = true end

      for i,link in pairs(target_crystal.linked_from) do
        if link_crystal == link.source then
          target_crystal.linked_from[i] = nil
          do_not_add = true
          print("gah")
        end
      end

      for i,link in pairs(link_crystal.linked_from) do
        if target_crystal == link.source then
          link_crystal.linked_from[i] = nil
          do_not_add = true
          print("guh")
        end
      end

      if not do_not_add then
        print("wut")
        local collide = false
        local the_link = Link:new(link_crystal, target_crystal)
        for _,crystal in pairs(level.crystals) do
            for _,link in pairs(crystal.linked_from) do -- TODO: Is this correct?
                if (the_link:collision_check(link)) then
                    collide = true
                end
                print("hah?")
            end
            for _,wall in pairs(wall_link_list) do
                print("huh?")
                if (the_link:collision_check(wall)) then
                    collide = true
                end
            end
        end

        if not collide then
            table.insert(target_crystal.linked_from, Link:new(link_crystal, target_crystal))
            if not no_sfx then
                audio['link_finished']:stop()
                audio['link_finished']:play()
            end
        end
      end
      --link_y, link_x, link_id, link_crystal, target_id, target_crystal = nil, nil, nil, nil, nil, nil
      update_render_lists()
    end
  elseif button == 2 then -- stop linking
    linking = false
  end
end

function love.update(dt)
    if game_paused then return end
    last_dt = dt
    total_dt = total_dt + dt

    -- Save the value of every cystal
    local old_values = {}
    local old_inputs = {}
    for _,crystal in pairs(level.crystals) do
        old_values[crystal.ID] = crystal.value
        old_inputs[crystal.ID] = crystal.inputs
    end
    -- Find out and store the new values...
    local new_values = {}
    local new_inputs = {}
    for _,crystal in pairs(level.crystals) do
        -- TODO: Find what on earth this is linked to!!
        -- TODO: Abstract a bit?
        -- TODO: How will two inputs work?
        --print(old_inputs[crystal.ID])
        new_values[crystal.ID] = crystal.operation(old_values[crystal.ID], unpack(old_inputs[crystal.ID]))
    end

    -- Now update the list of inputs!
    for _,crystal in pairs(level.crystals) do
        local i = 0
        new_inputs[crystal.ID] = {}
        for _,link in pairs(crystal.linked_from) do
            i = i+1
            new_inputs[crystal.ID][i] = new_values[link.source.ID] or 0
        end
    end

    -- Save the values to the crystals!
    for _,crystal in pairs(level.crystals) do
        crystal.value = new_values[crystal.ID]
        crystal.inputs = new_inputs[crystal.ID]
    end

    -- check if the goal is reached
    goal_reached = check_goals()
end
