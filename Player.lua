Player = {}

function Player:new( x, y, w, h, speed, collisionClass )
    local obj = Entity:new( x, y, w, h, speed, collisionClass )

    obj.animations["iddle_bottom"] = Sprite:new("Resource/Player/Player.png", 0, 0, 32, 32, 6, .2)
    obj.animations["iddle_right"] = Sprite:new("Resource/Player/Player.png", 0, 32, 32, 32, 6, .2)
    obj.animations["iddle_up"] = Sprite:new("Resource/Player/Player.png", 0, 64, 32, 32, 6, .2)
    obj.animations["walk_bottom"] = Sprite:new("Resource/Player/Player.png", 0, 32 * 3, 32, 32, 6, .2)
    obj.animations["walk_right"] = Sprite:new("Resource/Player/Player.png", 0, 32 * 4, 32, 32, 6, .2)
    obj.animations["walk_up"] = Sprite:new("Resource/Player/Player.png", 0, 32 * 5, 32, 32, 6, .2)
    obj.currentAnimation = "walk_up"

    obj.camera = {
        cameraPosition = Vector2:new(x, y - 16 * scale),
        radius = 50,
        maxSpeed = obj.speed * 2
    }

    obj.VisualElement = VisualElement:new(obj.animations["iddle_bottom"], 1, function ()
        if obj.animations[obj.currentAnimation] then
            local x, y = obj:GetPosition()
            obj.animations[obj.currentAnimation]:draw(x, y, 0, 4)
        elseif obj.currentAnimation == "walk_left" then
            local x, y = obj:GetPosition()
            obj.animations["walk_right"]:draw(x + 16 * 2 * scale, y, 0, 4, -1)
        elseif obj.currentAnimation == "iddle_left" then
            local x, y = obj:GetPosition()
            obj.animations["iddle_right"]:draw(x + 16 * 2 * scale, y, 0, 4, -1)
        end

        return true
    end)

    obj.VisualElement.pivotY = 4

    setmetatable(obj, self)
    self.__index = function (table, key)
        return Player[key] or Entity[key]
    end

    return obj
end

function Player:AnimationManager (vector2)
    local newAnim = "iddle_bottom"

    if vector2.y > 0 then
        newAnim = "walk_bottom"
    elseif vector2.y < 0 then
        newAnim = "walk_up"
    end

    if vector2.x > 0 then
        newAnim = "walk_right"
    elseif vector2.x < 0 then
        newAnim = "walk_left"
    end

    if self.currentAnimation ~= newAnim and not (newAnim == "iddle_bottom" and string.sub(self.currentAnimation, 1, 5) == "iddle") then
        if self.animations[self.currentAnimation] then
            self.animations[self.currentAnimation]:Null()
        elseif self.currentAnimation == "walk_left" then
            self.animations["walk_right"]:Null()
        elseif self.currentAnimation == "iddle_left" then
            self.animations["iddle_right"]:Null()
        end

        if newAnim == "iddle_bottom" then
            if self.currentAnimation == "walk_bottom" then
            elseif self.currentAnimation == "walk_right" then
               newAnim = "iddle_right"
            elseif self.currentAnimation == "walk_up" then
                newAnim = "iddle_up"
            elseif self.currentAnimation == "walk_left" then
                newAnim = "iddle_left"
            end
        end

        self.currentAnimation = newAnim
    end
end

function Player:move(vector2)
    vector2 = vector2:Normalize()
    self.body:setLinearVelocity(vector2.x * self.speed, vector2.y * self.speed)
    self.VisualElement.pos.x, self.VisualElement.pos.y = self.body:getPosition()
    VisualSort(self.VisualElement.zIndex)
end

function Player:update( dt )
    if self.animations[self.currentAnimation] then
        self.animations[self.currentAnimation]:update( dt )
    elseif self.currentAnimation == "walk_left" then
        self.animations["walk_right"]:update( dt )
    elseif self.currentAnimation == "iddle_left" then
        self.animations["iddle_right"]:update( dt )
    end

    local inputVector = InputSystem:getVector2()

    self:move(inputVector)
    self:AnimationManager(inputVector)

    cam:lookAt(self:GetCameraPosition())
end

-- function Player:draw()
--     if self.animations[self.currentAnimation] then
--         local x, y = self:GetPosition()

--         self.animations[self.currentAnimation]:draw(x, y, 0, 4)
--     elseif self.currentAnimation == "walk_left" then
--         local x, y = self:GetPosition()

--         self.animations["walk_right"]:draw(x + 16 * 2 * scale, y, 0, 4, -1)
--     elseif self.currentAnimation == "iddle_left" then
--         local x, y = self:GetPosition()

--         self.animations["iddle_right"]:draw(x + 16 * 2 * scale, y, 0, 4, -1)
--     end
-- end

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
        self.camera.cameraPosition.x, self.camera.cameraPosition.y = self.camera.cameraPosition.x + (dx * 1.5), self.camera.cameraPosition.y + (dy * 1.5)
    else
        self.camera.cameraPosition.x, self.camera.cameraPosition.y = self.camera.cameraPosition.x + dx, self.camera.cameraPosition.y + dy
    end

    return self.camera.cameraPosition.x, self.camera.cameraPosition.y
end


--[[
    Planuri pentru maine:
        -- Realizarea miscarii camerei cu intarziere
        Inceperea genrarii -- cel putin gandirea la cum trebuie sa arate
    Planuri la general : 
        Realizarea primului animal
]]