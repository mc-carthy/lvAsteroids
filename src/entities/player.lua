local V = require('src.utils.vector2')
local Missile = require('src.entities.missile')

local player = {}

local PI = math.pi

local image = love.graphics.newImage("assets/img/player/ship.png")
local imageW = image:getWidth()
local imageH = image:getHeight()
local transSpeed = 100
local rotSpeed = 5

local function _fire(self, dt)
    if self.canFire then
        self.canFire = false
        self.timeToNextFire = self.fireRate
        table.insert(self.missiles, Missile.create(self.x, self.y, self.rot))
    else
        if self.timeToNextFire < 0 then
            self.canFire = true
        end
    end
end

local function _input(self, dt)
    local dx, dy = V.pointFromRotDist(self.rot, transSpeed * dt)
    
    local up = love.keyboard.isDown('up') or love.keyboard.isDown('w')
    local down = love.keyboard.isDown('down') or love.keyboard.isDown('s')
    local left = love.keyboard.isDown('left') or love.keyboard.isDown('a')
    local right = love.keyboard.isDown('right') or love.keyboard.isDown('d')
    local fire = love.keyboard.isDown('space') or love.mouse.isDown(1)
    
    if up then
        self.x = self.x + dx
        self.y = self.y - dy
    end
    if down then
        self.x = self.x - dx
        self.y = self.y + dy
    end
    if left then
        self.rot = self.rot - rotSpeed * dt
    end
    if right then
        self.rot = self.rot + rotSpeed * dt
    end
    if fire then
        _fire(self, dt)
    end
end

local function _updateMissiles(self, dt)
    for i, m in pairs(self.missiles) do
        m:update(dt)
        if m.done then
            table.remove(self.missiles, i)
        end
    end
end

local function _drawMissiles(self, dt)
    for _, m in pairs(self.missiles) do
        m:draw()
    end
end

local function update(self, dt)
    _updateMissiles(self, dt)
    _input(self, dt)
    self.timeToNextFire = self.timeToNextFire - dt
end

local function draw(self)
    _drawMissiles(self)
    love.graphics.draw(image, self.x, self.y, self.rot, 0.5, 0.5, imageW / 2, imageH / 2)
end

function player.create(x, y)
    local inst = {}

    inst.x = x
    inst.y = y
    inst.rot = 0
    inst.missiles = {}
    inst.canFire = true
    inst.fireRate = 0.5
    inst.timeToNextFire = 0

    inst.draw = draw
    inst.update = update

    return inst
end

return player