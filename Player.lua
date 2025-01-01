Player = {}

function Player:new( x, y, w, h, speed, collisionClass )
    local obj = Entity:new( x, y, w, h, speed, collisionClass )

    obj.animations["iddle"] = Sprite:new("Resource/Player/Player.png", 0, 0, 32, 32, 6, .2)
    obj.currentAnimation = "iddle"


    setmetatable(obj, self)
    self.__index = function (table, key)
        return Player[key] or Entity[key]
    end

    return obj
end

function Player:move(vector2)
    self.body:setLinearVelocity(vector2.x * self.speed, vector2.y * self.speed)
end

function Player:update( dt )
    if self.animations[self.currentAnimation] then
        self.animations[self.currentAnimation]:update( dt )
    end

    self:move(InputSystem:getVector2())
end

function Player:draw()
    local x, y = self:GetPosition(4)

    if self.animations[self.currentAnimation] then
        self.animations[self.currentAnimation]:draw(x, y, 0, 4)
    end
end

function Player:GetPosition(sacle)
    local x, y = self.body:getPosition()
    return x - 16 * scale, y - 16 * scale - 6 * scale
end

function Player:GetCameraPosition (scale)
    local x, y = self.body:getPosition()
    return x, y - 16 * scale
end

-- Trebuie sa creez o biluta care merge fictiv din urma jucatorului si ii creste viteza cu cat este mai departe de jucator, aceasta bila este pozitia camerei

--[[
    Planuri pentru maine:
        Realizarea miscarii camerei cu intarziere
        Inceperea genrarii -- cel putin gandirea la cum trebuie sa arate
    Planuri la general : 
        Realizarea primului animal
]]