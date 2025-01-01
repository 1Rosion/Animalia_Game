Entity = {}

--[[
    Chestii pe care trebuie sa le aiba un element de tip entity:
        Body - un obiect de tip corp fizic
        Sprite - cu animatii si o functie pentru gestionarea acestora
        
]]


function Entity:new( x, y, w, h, speed, collisionClass )
    local obj = {}

    obj.x = x or 0
    obj.y = y or 0
    obj.w = w or 1
    obj.h = h or 1
    obj.speed = speed or 5

    obj.body = world:newBSGRectangleCollider(x, y, w, h, 10)
    obj.body:setCollisionClass(collisionClass)
    obj.body:setFixedRotation(true)


    obj.animations = {
        -- ["name"] = Sprite:new("Resource/Player/Player.png", 0, 0, 32, 32, 6, .2) -- animations have names and sprites
    }
    obj.currentAnimation = ""  -- Animation name


    setmetatable(obj, self)
    self.__index = function (table, key)
        return Entity[key] or Element[key]
    end

    return obj
end