Plant = {} -- Patern for plats

function Plant:new (x, y, w, h)
    local obj = {}

    obj.pos = Vector2:new(x or 0, y or 0)
    -- obj.body = world:newBSGRectangleCollider(obj.pos.x, obj.pos.y, w or 20, h or 20, 10, {ignores = {"Player"}})

    setmetatable(obj, self)
    self.__index = self

    return obj
end
-- Flori, tufis, copac
Flower = {}

function Flower:new(x, y)
    local obj = Plant:new(x, y)

    obj.sprite = Sprite:new("Resource/Outdoor decoration/Outdoor_Decor_Free.png", 0, 128, 16, 16, 2, 0.1)
    obj.VE = VisualElement:new(obj.sprite, 1)
    obj.VE.pos.x = x
    obj.VE.pos.y = y
    obj.VE.pivotY = 50

    setmetatable(obj, self)
    self.__index = self

    return obj
end

Wafels = {}

function Wafels:new(x, y)
    local obj = Plant:new(x, y)

    obj.sprite = Sprite:new("Resource/Outdoor decoration/Basic_Grass_Biom_things.png", 16, 48, 16, 16, 1, 0.1)
    obj.VE = VisualElement:new(obj.sprite, 1)
    obj.VE.pos.x = x
    obj.VE.pos.y = y
    obj.VE.pivotY = 60

    setmetatable(obj, self)
    self.__index = self

    return obj
end

Tree = {}

function Tree:new(x, y)
    local obj = Plant:new(x, y)

    obj.sprite = Sprite:new("Resource/Outdoor decoration/Basic_Grass_Biom_things.png", 0, 0, 16, 32, 1, 0.1)
    obj.VE = VisualElement:new(obj.sprite, 1)
    obj.VE.pos.x = x
    obj.VE.pos.y = y
    obj.VE.pivotY = 105

    obj.body = world : newBSGRectangleCollider (obj.pos.x + 17, obj.pos.y + 95, 30, 15, 10)
    obj.body:setType("static")
    obj.body:setCollisionClass("Plant")

    setmetatable(obj, self)
    self.__index = self

    return obj
end