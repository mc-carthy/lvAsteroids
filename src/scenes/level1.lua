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
    for i = 1, 2 do
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
    if key == 'return' then
        Scene.Load('level2')
    end
end

return level1