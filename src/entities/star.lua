local star = {}

local function update(self, dt)
    self.y = self.y + self.vy * dt
    if self.y > love.graphics.getHeight() + self.rad then
        self.y = -love.math.random(0, 100)
    end
end

local function draw(self)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle('fill', self.x, self.y, self.rad, 16)
end

function star.create(y)
    local inst = {}

    inst.x = love.math.random(0, love.graphics.getWidth())
    inst.y = y or -love.math.random(0, 100)

    local size = love.math.random(0, 2)
    if size == 0 then
        inst.vy = 10
        inst.rad = 0.5
    elseif size == 1 then
        inst.vy = 20
        inst.rad = 1
    elseif size == 2 then
        inst.vy = 30
        inst.rad = 2.5
    end

    inst.update = update
    inst.draw = draw

    return inst
end

return star