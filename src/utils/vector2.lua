local V = {}

local pow = math.pow
local sqrt = math.sqrt

function V.angle(x1, y1, x2, y2)
    local rad = -math.atan2(y2 - y1, x2 - x1)
    local deg = math.deg(rad)

    if deg < 0 then deg = deg + 360 end

    return deg
end

function V.distance(v1, v2)
    return V.magnitude(v1.x - v2.x, v1.y - v2.y)
end

function V.magnitude(x, y)
    return sqrt(pow(x, 2) + pow(y, 2))
end

function V.normalised(x, y)
    mag = V.magnitude(x, y)
    nX = x / mag
    ny = y / mag
    return nx, ny
end

function V.pointFromRotDist(rot, dist)
    local x = dist * math.cos(rot)
    local y = dist * -math.sin(rot)

    return x, y
end

return V
