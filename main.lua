local EntityManager = require('src.entities.entityManager')
local Player = require('src.entities.player')
local Asteroid = require('src.entities.asteroid')
local Star = require('src.entities.star')

function love.load()
    entityManager = EntityManager.create()
    for i = 1, 100 do
        entityManager:addEntity(Star.create(love.math.random(0, love.graphics.getHeight())))
    end
    for i = 1, 5 do
        entityManager:addEntity(Asteroid.create(entityManager, love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight())))
    end
    entityManager:addEntity(Player.create(entityManager, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2))
end

function love.update(dt)
    entityManager:update(dt)
end

function love.draw()
    entityManager:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end