Element = {}

function Element:new()
    setmetatable({}, self)
    self.__index = self

    return {}
end

function Element:update(dt)
end

function Element:draw()
end