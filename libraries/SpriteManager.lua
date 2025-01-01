Sprite = {}


---comment
---@param path string
---@param x number
---@param y number
---@param width number
---@param height number
---@param numberOfFrames number
---@param timePerFrame number
---@return table
function Sprite:new(path, x, y, width, height, numberOfFrames, timePerFrame)
    local obj = setmetatable({}, self)

    obj.originalImage = love.graphics.newImage (path)
    obj.originalImage:setFilter("nearest")
    obj.frames = {}

    obj.width = width or 16
    obj.height = height or 16

    for i = 1, numberOfFrames or 1 do
        table.insert(obj.frames,
                love.graphics.newQuad((x or 0) + (i - 1) * obj.width , y or 0, obj.width, obj.height, obj.originalImage:getWidth(), obj.originalImage:getHeight())
            )
    end

    obj.currentFrame = 1

    obj.timePerFrame = timePerFrame or .1
    obj.timer = 0


    self.__index = function (table, key)
        return Sprite[key] or Element[key]
    end

    return obj
end

function Sprite:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.timePerFrame then
        if self.currentFrame + 1 > #self.frames then
            self.currentFrame = 1
        else
            self.currentFrame = self.currentFrame + 1
        end

        self.timer = 0
    end
end

---Drawing animation on position 'x' and 'y' with 'r' as radius and in scale `scale`
---@param x number
---@param y number
---@param r number
---@param scale number
function Sprite:draw(x, y, r, scale, direct)
    love.graphics.draw(self.originalImage, self.frames[self.currentFrame], x or 0, y or 0, r or 0, (scale or 1) * (direct or 1), scale or 1 )
end

function Sprite:Null()
    self.currentFrame = 1
end