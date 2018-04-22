local menu = {}

local x = 0

function menu.load ()
    print "Menu loaded"
end

function menu.unload()
    print "Menu unloaded"
end

function menu.update(dt)
    x = x + 32 * dt
end

function menu.draw()
    print('drawing in menu')
    love.graphics.print("Hello from Main Menu, press enter to begin",x,0)
end

function menu.keypressed(key)
    if key == "return" then
        Scene.Load("level1")
    elseif key == "escape" then
        love.event.quit()
    end
end

return menu