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

function Vector2:LunigimeaVectorului ()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2:Normalize()
    local lungime = self:LunigimeaVectorului()
    if lungime == 0 then lungime = lungime + 0.001 end
    return Vector2:new(self.x / lungime, self.y / lungime)
end