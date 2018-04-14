local asteroid = {}

local debug = false

local image1 = love.graphics.newImage("assets/img/asteroids/asteroid1.png")
local image2 = love.graphics.newImage("assets/img/asteroids/asteroid2.png")
local image3 = love.graphics.newImage("assets/img/asteroids/asteroid3.png")
local image4 = love.graphics.newImage("assets/img/asteroids/asteroid4.png")
local images = { image1, image2, image3, image4 }
local imageScale = 0.5
local rotSpeedMin = -5
local rotSpeedMax = 5

local function split(self)
    if self.size >= 0.25 then
        self.entityManager:addEntity(asteroid.create(self.entityManager, self.x + love.math.random(-50, 50), self.y + love.math.random(-50, 50), self.size / 2))
        self.entityManager:addEntity(asteroid.create(self.entityManager, self.x + love.math.random(-50, 50), self.y + love.math.random(-50, 50), self.size / 2))
    end
end

local function update(self, dt)
    self.rot = self.rot + self.rotSpeed * dt
end

local function draw(self)
    love.graphics.draw(self.image, self.x, self.y, self.rot, imageScale * self.size, imageScale * self.size, self.image:getWidth() / 2, self.image:getHeight() / 2)
    if debug then
        love.graphics.circle("line", self.x, self.y, self.rad, 32)
    end
end

function asteroid.create(entityManager, x, y, size)
    local inst = {}

    inst.entityManager = entityManager
    inst.tag = 'asteroid'
    inst.x = x
    inst.y = y
    inst.rot = 0
    inst.size = size or 1
    inst.rotSpeed = love.math.random(rotSpeedMin, rotSpeedMax)
    inst.image = images[love.math.random(1, #images)]
    -- TODO: Refactor this to use a max function of width vs height
    inst.rad = 100 * imageScale * inst.size

    inst.split = split
    inst.update = update
    inst.draw = draw

    return inst
end

return asteroid