Scene = require "src/scenes/_sceneManager"

local InitialScene = "menu"

function love.load()
    Scene.Load(InitialScene)
end

function love.update(dt)
    Scene.update(dt)
end

function love.draw()
    Scene.draw()
end

function love.keypressed(key)
    Scene.keypressed(key)
end

function love.mousepressed(x, y, button)
    Scene.mousepressed(x, y, button)
end