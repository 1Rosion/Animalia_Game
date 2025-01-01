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
end

function love.resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    InputSystem:init()
    
    myPlayer:update( dt )
    world:update(dt)
    
    myPlayer:GetCameraPosition()
    local x, y = myPlayer:GetCameraPosition()
    cam:lookAt(x, y)
end

function love.draw()
    cam:attach()
    love.graphics.draw(love.graphics.newImage("Resource/Tiles/Beach_Tile.png"), 0, 0, 0, 4)
        --
        myPlayer:draw()
        -- world:draw()
    --    
    cam:detach()


    local vec = InputSystem:getVector2()
    love.graphics.print(vec.x .. " " .. vec.y)
end

