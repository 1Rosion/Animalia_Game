love = require "love"

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
scale = 4

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
    myPlayer:update( dt )
    world:update(dt)


    local x, y = myPlayer:GetCameraPosition(scale)
    cam:lookAt(x, y)
    love.keyboard.keysPressed = {}
end

function love.draw()
    cam:attach()
    love.graphics.draw(love.graphics.newImage("Resource/Tiles/Beach_Tile.png"), 0, 0, 0, 4)
        myPlayer:draw()
        world:draw()

        local vec = InputSystem:getVector2()

        cam:detach()
        love.graphics.print(vec.x .. " " .. vec.y)
end

