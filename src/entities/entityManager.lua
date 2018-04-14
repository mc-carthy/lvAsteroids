local entityManager = {}

local function addEntity(self, entity)
    table.insert(self.entities, entity)
end

local function _cleanUpDoneEntities(self)
    for i = #self.entities, 1, -1 do
        local e = self.entities[i]
        if e.done then
            table.remove(self.entities, i)
        end
    end
end

local function update(self, dt)
    for i = 1, #self.entities do
        if self.entities[i].update then
            self.entities[i]:update(dt)
        end
    end
    _cleanUpDoneEntities(self)
end

local function draw(self, dt)
    for i = 1, #self.entities do
        if self.entities[i].draw then
            self.entities[i]:draw(dt)
        end
    end
    _cleanUpDoneEntities(self)
end

function entityManager.create()
    local inst = {}

    inst.entities = {}

    inst.addEntity = addEntity

    inst.update = update
    inst.draw = draw

    return inst
end

return entityManager