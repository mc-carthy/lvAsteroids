local EntityManager = require('src.entities.entityManager')
local Player = require('src.entities.player')
local Asteroid = require('src.entities.asteroid')
local Star = require('src.entities.star')

local level2 = {}

function level2.load()
    entityManager = EntityManager.create()
    for i = 1, 100 do
        entityManager:addEntity(Star.create(love.math.random(0, love.graphics.getHeight())))
    end
    for i = 1, 5 do
        entityManager:addEntity(Asteroid.create(entityManager, love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight())))
    end
    entityManager:addEntity(Player.create(entityManager, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2))
end

function level2.update(dt)
    entityManager:update(dt)
end

function level2.draw()
    entityManager:draw()
end

function level2.keypressed(key)
    if key == 'escape' then
        Scene.Load("menu")
    end
end

return level2