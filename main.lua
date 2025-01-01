love = require "love"
scale = 4

local wf = require "libraries.windfield"
world = wf.newWorld(0, 0, true)

world:addCollisionClass("Player")


require "libraries.bassicFunctions"
require "libraries.vector2d"
require "elem"
require "libraries.SpriteManager"
require "Entity"
require "InputSystem"
require "Player"

local camera = require "libraries.camera"
cam = camera()

local myPlayer = Player:new(100, 100, 40, 20, 400, "Player")


function love.load()
    love.window.setTitle('Animalia')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    InputSystem:init()
    
    myPlayer:update( dt )
    world:update(dt)

    local x, y = myPlayer:GetCameraPosition()
    cam:lookAt(x, y)
    love.keyboard.keysPressed = {}
end

function love.draw()
    cam:attach()
    love.graphics.draw(love.graphics.newImage("Resource/Tiles/Beach_Tile.png"), 0, 0, 0, 4)
        --
        myPlayer:draw()
        world:draw()

        --[ Camer look at Point
            local r,g,b,a = love.graphics.getColor()
            love.graphics.setColor(1, 0, 0, 1)
            local x, y = myPlayer:GetCameraPosition()
            love.graphics.circle('fill', x, y, 3)
            love.graphics.setColor(r, g, b, a)
        --]

        --[ Cercul in care se va misca punctul camerei
            local x, y = myPlayer.body:getPosition()
            y = y - 16 * scale
            love.graphics.circle('line', x, y, 50)
        --]
    --    
    cam:detach()


    local vec = InputSystem:getVector2()
    love.graphics.print(vec.x .. " " .. vec.y)
end

