local Player = require('src.entities.player')

function love.load()
    player = Player.create(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end