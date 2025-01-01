Player = {}

function Player:new( x, y, w, h, speed, collisionClass )
    local obj = Entity:new( x, y, w, h, speed, collisionClass )

    obj.animations["iddle"] = Sprite:new("Resource/Player/Player.png", 0, 0, 32, 32, 6, .2)
    obj.currentAnimation = "iddle"

    obj.camera = {
        cameraPosition = Vector2:new(x, y - 16 * scale),
        radius = 50,
        maxSpeed = obj.speed * 2
    }

    setmetatable(obj, self)
    self.__index = function (table, key)
        return Player[key] or Entity[key]
    end

    return obj
end

function Player:move(vector2)
    vector2 = vector2:Normalize()
    self.body:setLinearVelocity(vector2.x * self.speed, vector2.y * self.speed)
end

function Player:update( dt )
    if self.animations[self.currentAnimation] then
        self.animations[self.currentAnimation]:update( dt )
    end

    self:move(InputSystem:getVector2())
end

function Player:draw()
    if self.animations[self.currentAnimation] then
        local x, y = self:GetPosition()

        self.animations[self.currentAnimation]:draw(x, y, 0, 4)
    end
end

function Player:GetPosition()
    local x, y = self.body:getPosition()
    return x - 16 * scale, y - 16 * scale - 6 * scale
end

function Player:GetCameraPosition ()
    local pxy = Vector2:new(self.body:getPosition())
    pxy.y = pxy.y - 16 * scale -- pozitia initiala a camerei si pozitia in spre care se misca constat

    local distance = math.sqrt((self.camera.cameraPosition.x - pxy.x)^2 + (self.camera.cameraPosition.y - pxy.y)^2)
    local dx, dy = (pxy.x - self.camera.cameraPosition.x) / distance, (pxy.y - self.camera.cameraPosition.y) / distance

    if distance > self.camera.radius then
        self.camera.cameraPosition.x, self.camera.cameraPosition.y = self.camera.cameraPosition.x + dx * 2, self.camera.cameraPosition.y + dy * 2
    else
        self.camera.cameraPosition.x, self.camera.cameraPosition.y = self.camera.cameraPosition.x + dx, self.camera.cameraPosition.y + dy
    end

    return self.camera.cameraPosition.x, self.camera.cameraPosition.y
end

-- Trebuie sa creez o biluta care merge fictiv din urma jucatorului si ii creste viteza cu cat este mai departe de jucator, aceasta bila este pozitia camerei

--[[
    Planuri pentru maine:
        Realizarea miscarii camerei cu intarziere
        Inceperea genrarii -- cel putin gandirea la cum trebuie sa arate
    Planuri la general : 
        Realizarea primului animal
]]