InputSystem = {}


function InputSystem:getVector2()
    local vec2 = { x = 0, y = 0}

    if love.keyboard.isDown("a") then
        vec2.x = -1
    end

    if love.keyboard.isDown("w") then
        vec2.y = -1
    end

    if love.keyboard.isDown("d") then
        vec2.x = 1
    end

    if love.keyboard.isDown("s") then
        vec2.y = 1
    end

    return vec2
end