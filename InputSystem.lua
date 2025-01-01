InputSystem = {
    joistic = nil
}

function InputSystem:init()
    local controler = love.joystick.getJoysticks()

    if #controler > 0 then
        self.joistic = controler[1]
    else
        self.joistic = nil
    end
    
end

function InputSystem:getVector2()
    local vec2 = { x = 0, y = 0}

    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        vec2.x = -1
    end

    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        vec2.y = -1
    end

    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        vec2.x = 1
    end

    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        vec2.y = 1
    end

    if self.joistic ~= nil and self.joistic:isGamepad() then
        vec2.x = self.joistic:getAxis(1)
        vec2.y = self.joistic:getAxis(2)
    end

    return vec2
end