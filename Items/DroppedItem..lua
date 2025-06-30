DroppedItem = {}

function DroppedItem:New(x, y, sprite)
    local obj = {}

    obj.pos = Vector2:new(x, y)
    obj.VE =  VisualElement:new(sprite, 1)

    obj.body = world : newCircleCollider(x, y, 10, {ignores = {"Plant", "Ground"}})

    setmetatable(obj, self)
    self.__index = self

    return obj
end

Item = {}

function Item:new(sprite)
    local obj = {}
    

    
end

inventar = {}

function inventar:new(x, y)
    local obj = {}

    
end




