love = require "love"
scale = 4

local wf = require "libraries.windfield"
world = wf.newWorld(0, 0, true)

world:addCollisionClass("Player")
world:addCollisionClass("Ground")
world:addCollisionClass("Plant", {ignores = {"Ground"}})


local camera = require "libraries.camera"
cam = camera()

require "elem"
require "libraries.bassicFunctions"
require "libraries.vector2d"
require "libraries.SpriteManager"
require "Entity"
require "InputSystem"
require "Player"
require "Plants.plant"

require "Generator.generator"


local seed = 1126948
Generator:newMap(100, 100, seed)
-- local image, image1 = Generator:GettingDataFromGPU()
local row = 1
local myPlayer = Player:new(100, 100, 40, 20, 400, "Player")

Tree:new(0, 0)

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
end

function love.draw()
    cam:attach()
        --
        world:draw()
        Generator:DrawMap()
        -- myPlayer:draw()

        Draw()


        if row <= Generator.h then
            Generator:AutoTiling(row)
            row = row + 1
        end
    --     local x , y = myPlayer:GetPosition()
    --     x = x + 16 * scale
    --     y = y + 16
    --     love.graphics.circle('line', x, y, myPlayer.camera.radius)
        myPlayer:GetCameraPosition()
    --     love.graphics.circle('fill', x, y, 2)
    -- --
    cam:detach()
end

--[[ 
    Ce fac azi: 
        -- reparat ******* Reparat normalizarea vectorului pentru a putea merge incet
        * Sa pot merge doar pe pamanat -- implica generearea ge colidere
        * Aparitia plantelor -- Trebuie sa apara la inceput mai multe, dupa care sa creasca in ceva timp cate o planta
        * Constructie


]]