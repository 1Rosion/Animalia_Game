Vector2 = {}

function Vector2:new(x, y)
    local obj = {}

    obj.x = x or 0
    obj.y = y or 0
    
    setmetatable(obj, self)
    self.__index = self

    return obj
end

function Vector2:Clone(vec)
    local vec2 = vec or self
    return Vector2:new(vec2.x, vec2.y)
end

function Vector2:NormalizeVector(vec)
    if not vec and self.x == 1 or self.y == 1 then
        return Vector2:new(.71, .71)
    end

    return self:Clone()
end

function Vector2:Substracting(vec1, vec2)
    if not vec1 then return Vector2:new(0, 0) end
    if not vec2 then return Vector2:new(self.x - vec1.x, self.y - vec1.y) end
    return Vector2:new(vec1.x - vec2.x, vec1.y - vec2.y)
end

function Vector2:abs()
    self.x = math.abs(self.x)
    self.y = math.abs(self.y)

    return self
end

function Vector2:Distance()
    return math.sqrt(self.x^2 + self.y^2)
end