local V = require('src.utils.vector2')
local Col = require('src.utils.collision')

local missile = {}

local debug = true

local image = love.graphics.newImage("assets/img/player/missile.png")
local imageW = image:getWidth()
local imageH = image:getHeight()
local imageScale = 0.5

local defaultSpeed = 200
local outOfBoundsBuffer = imageW + imageH

local function _move(self, dt)
    local dx, dy = V.pointFromRotDist(self.rot, self.speed * dt)
    self.x = self.x + dx
    self.y = self.y - dy
end

local function _checkForOutOfBounds(self)
    if (
        self.x < -outOfBoundsBuffer or
        self.x > love.graphics.getWidth() + outOfBoundsBuffer or 
        self.y < -outOfBoundsBuffer or
        self.y > love.graphics.getHeight() + outOfBoundsBuffer
    ) then
        self.done = true
    end
end

local function _checkForAsteroidCollisions(self)
    for _, e in pairs(self.entityManager.entities) do
        if e.tag == 'asteroid' then
            if Col.rectCircle(self, e) then
                e.done = true
                self.done = true
            end
        end
    end
end

local function update(self, dt)
    _checkForAsteroidCollisions(self)
    _checkForOutOfBounds(self)
    _move(self, dt)
end

local function draw(self)
    love.graphics.draw(image, self.x, self.y, self.rot, imageScale, imageScale, imageW / 2, imageH / 2)
    if debug then
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.circle("fill", self.x + (math.cos(self.rot) * self.w / 2 + math.sin(self.rot) * self.h / 2), self.y + (math.cos(self.rot) * self.h / 2 - math.sin(self.rot) * self.w / 2), 2, 8)
        love.graphics.circle("fill", self.x + (math.cos(self.rot) * self.w / 2 + math.sin(self.rot) * self.h / 2), self.y - (math.cos(self.rot) * self.h / 2 - math.sin(self.rot) * self.w / 2), 2, 8)
        love.graphics.circle("fill", self.x - (math.cos(self.rot) * self.w / 2 + math.sin(self.rot) * self.h / 2), self.y + (math.cos(self.rot) * self.h / 2 - math.sin(self.rot) * self.w / 2), 2, 8)
        love.graphics.circle("fill", self.x - (math.cos(self.rot) * self.w / 2 + math.sin(self.rot) * self.h / 2), self.y - (math.cos(self.rot) * self.h / 2 - math.sin(self.rot) * self.w / 2), 2, 8)
        -- love.graphics.circle("fill", self.x + self.w / 2, self.y + self.h / 2, 2, 8)
        -- love.graphics.circle("fill", self.x + self.w / 2, self.y - self.h / 2, 2, 8)
        -- love.graphics.circle("fill", self.x - self.w / 2, self.y + self.h / 2, 2, 8)
        -- love.graphics.circle("fill", self.x - self.w / 2, self.y - self.h / 2, 2, 8)
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function missile.create(entityManager, x, y, rot, speed)
    local inst = {}

    inst.tag = 'missile'
    inst.entityManager = entityManager
    inst.x = x
    inst.y = y
    inst.w = 40 * imageScale
    inst.h = 10 * imageScale
    inst.rot = rot
    inst.speed = speed or defaultSpeed

    inst.update = update
    inst.draw = draw

    return inst
end

return missile