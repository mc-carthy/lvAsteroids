local EntityManager = require('src.entities.entityManager')
local Player = require('src.entities.player')
local Asteroid = require('src.entities.asteroid')
local Star = require('src.entities.star')

local level1 = {}

function level1.load()
    entityManager = EntityManager.create()
    for i = 1, 100 do
        entityManager:addEntity(Star.create(love.math.random(0, love.graphics.getHeight())))
    end
    for i = 1, 5 do
        entityManager:addEntity(Asteroid.create(entityManager, love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight())))
    end
    entityManager:addEntity(Player.create(entityManager, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2))
end

function level1.update(dt)
    entityManager:update(dt)
end

function level1.draw()
    entityManager:draw()
end

function level1.keypressed(key)
    if key == 'escape' then
        Scene.Load("menu")
    end
end

return level1

-- local level1 = {}

-- local y = 0

-- function level1.load ()
--     print "Level 2 loaded"
-- end

-- function level1.unload()
--     print "Level 2 unloaded"
-- end

-- function level1.update(dt)
--     y = y + 32 * dt
-- end

-- function level1.draw()
--     love.graphics.print("Hello from level2",0,y)
-- end

-- function level1.keypressed(key)
--     if key == "return" then
--         Scene.Load("level1")
--     elseif key == "escape" then
--         love.event.quit()
--     end
-- end

-- return level1