local Player = require('src.entities.player')
local Asteroid = require('src.entities.asteroid')

function love.load()
    player = Player.create(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    asteroid = Asteroid.create(love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight()))
end

function love.update(dt)
    player:update(dt)
    asteroid:update(dt)
end

function love.draw()
    player:draw()
    asteroid:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end