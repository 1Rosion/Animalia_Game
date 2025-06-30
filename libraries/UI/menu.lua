menu = {}

function menu:DrawMenu()
    local w, h = love.window.getMode()
    local canvas = love.graphics.newCanvas(w, h)
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(1, 01, 01, 1)
    love.graphics.rectangle('fill',0, 0, w, h)

    love.graphics.setCanvas()

    love.graphics.draw(canvas)

end