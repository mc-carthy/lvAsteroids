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
        local dx = love.math.random(-10, 10)
        local dy = love.math.random(-10, 10)
        self.entityManager:addEntity(asteroid.create(self.entityManager, self.x, self.y, self.size / 2, self.vx + dx, self.vy + dy))
        self.entityManager:addEntity(asteroid.create(self.entityManager, self.x, self.y, self.size / 2, self.vx - dx, self.vy - dy))
    end
end

local function update(self, dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    self.rot = self.rot + self.rotSpeed * dt
end

local function draw(self)
    love.graphics.draw(self.image, self.x, self.y, self.rot, imageScale * self.size, imageScale * self.size, self.image:getWidth() / 2, self.image:getHeight() / 2)
    if debug then
        love.graphics.circle("line", self.x, self.y, self.rad, 32)
    end
end

function asteroid.create(entityManager, x, y, size, vx, vy)
    local inst = {}

    inst.entityManager = entityManager
    inst.tag = 'asteroid'
    inst.x = x
    inst.y = y
    inst.vx = vx or love.math.random(-20, 20)
    inst.vy = vy or love.math.random(-20, 20)
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