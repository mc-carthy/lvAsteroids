local asteroid = {}

local image1 = love.graphics.newImage("assets/img/asteroids/asteroid1.png")
local image2 = love.graphics.newImage("assets/img/asteroids/asteroid2.png")
local image3 = love.graphics.newImage("assets/img/asteroids/asteroid3.png")
local image4 = love.graphics.newImage("assets/img/asteroids/asteroid4.png")
local images = { image1, image2, image3, image4 }
local imageScale = 0.5
local rotSpeedMin = -5
local rotSpeedMax = 5

local function update(self, dt)
    self.rot = self.rot + self.rotSpeed * dt
end

local function draw(self)
    love.graphics.draw(self.image, self.x, self.y, self.rot, imageScale * self.size, imageScale * self.size, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function asteroid.create(x, y, size)
    local inst = {}

    inst.x = x
    inst.y = y
    inst.rot = 0
    inst.size = size or 1
    inst.rotSpeed = love.math.random(rotSpeedMin, rotSpeedMax)
    inst.image = images[love.math.random(1, #images)]

    inst.update = update
    inst.draw = draw

    return inst
end

return asteroid