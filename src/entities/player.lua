local V = require('src.utils.vector2')

local player = {}

local PI = math.pi

local image = love.graphics.newImage("assets/img/player/ship.png")
local imageW = image:getWidth()
local imageH = image:getHeight()
local transSpeed = 100
local rotSpeed = 5

local function _input(self, dt)
    local dx, dy = V.pointFromRotDist(self.rot, transSpeed * dt)
    if love.keyboard.isDown('up') then
        self.x = self.x + dx
        self.y = self.y - dy
    end
    if love.keyboard.isDown('down') then
        self.x = self.x - dx
        self.y = self.y + dy
    end
    if love.keyboard.isDown('left') then
        self.rot = self.rot - rotSpeed * dt
    end
    if love.keyboard.isDown('right') then
        self.rot = self.rot + rotSpeed * dt
    end
end

local function update(self, dt)
    _input(self, dt)
end

local function draw(self)
    love.graphics.draw(image, self.x, self.y, self.rot, 0.5, 0.5, imageW / 2, imageH / 2)
end

function player.create(x, y)
    local inst = {}

    inst.x = x
    inst.y = y
    inst.rot = 0

    inst.draw = draw
    inst.update = update

    return inst
end

return player