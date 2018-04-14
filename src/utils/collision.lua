local V = require('src.utils.vector2')

local collision = {}

function collision.AABB(a, b)
    assert(a.x ~= nil and a.y ~= nil and b.x ~= nil and b.y ~= nil, "Both entities require x and y attributes for AABB collision detection")
    return
        a.x + a.w / 2 > b.x - b.w / 2 and 
        b.x + b.w / 2 > a.x - a.w / 2 and
        a.y + a.h / 2 > b.y - b.h / 2 and 
        b.y + b.h / 2 > a.y - a.h / 2
end

function collision.circle(a, b)
    assert(a.x ~= nil and a.y ~= nil and b.x ~= nil and b.y ~= nil, "Both entities require x and y attributes for circle collision detection")
    assert(a.rad ~= nil and b.rad ~= nil, "Both entities require a rad attribute for circle collision detection")
    return V.magnitude(math.abs(a.x - b.x), math.abs(a.y - b.y)) < a.rad + b.rad
end

function collision.rectCircle(rect, circ)
    -- TODO: This implementation form an AABB around the rotated rect
    -- Reconfigure so that the bounding box rotates in line with rect.rot
    local a = {
        x = rect.x + (math.cos(rect.rot) * rect.w / 2 + math.sin(rect.rot) * rect.h / 2),
        y = rect.y + (math.cos(rect.rot) * rect.h / 2 + math.sin(rect.rot) * rect.w / 2),
        rad = 0
    }
    local b = {
        x = rect.x + (math.cos(rect.rot) * rect.w / 2 + math.sin(rect.rot) * rect.h / 2),
        y = rect.y - (math.cos(rect.rot) * rect.h / 2 + math.sin(rect.rot) * rect.w / 2),
        rad = 0
    }
    local c = {
        x = rect.x - (math.cos(rect.rot) * rect.w / 2 + math.sin(rect.rot) * rect.h / 2),
        y = rect.y + (math.cos(rect.rot) * rect.h / 2 + math.sin(rect.rot) * rect.w / 2),
        rad = 0
    }
    local d = {
        x = rect.x - (math.cos(rect.rot) * rect.w / 2 + math.sin(rect.rot) * rect.h / 2),
        y = rect.y - (math.cos(rect.rot) * rect.h / 2 + math.sin(rect.rot) * rect.w / 2),
        rad = 0
    }
    local points = { a, b, c, d }
    
    for _, p in pairs(points) do
        if collision.circle(p, circ) then return true end
    end
    return false
end

return collision