local V = require('src.utils.vector2')

local missile = {}

local image = love.graphics.newImage("assets/img/player/missile.png")
local imageW = image:getWidth()
local imageH = image:getHeight()

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

local function update(self, dt)
    _checkForOutOfBounds(self)
    _move(self, dt)
end

local function draw(self)
    love.graphics.draw(image, self.x, self.y, self.rot, 0.5, 0.5, imageW / 2, imageH / 2)
end

function missile.create(x, y, rot, speed)
    local inst = {}

    inst.x = x
    inst.y = y
    inst.rot = rot
    inst.speed = speed or defaultSpeed

    inst.update = update
    inst.draw = draw

    return inst
end

return missile