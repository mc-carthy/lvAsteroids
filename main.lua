local EntityManager = require('src.entities.entityManager')
local Player = require('src.entities.player')
local Asteroid = require('src.entities.asteroid')

function love.load()
    entityManager = EntityManager.create()
    entityManager:addEntity(Player.create(entityManager, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2))
    entityManager:addEntity(Asteroid.create(entityManager, love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight())))
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