love = require "love"
scale = 4
local play = true

require "libraries.UI.menu"
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
local isTreeAdded = false
local myPlayer = Player:new(100, 100, 40, 20, 400, "Player")

-- Flower:new(0, 0)

function love.load()
    love.graphics.setBackgroundColor(0,255 / 149, 255/ 233,1)
    love.window.setTitle('Animalia')
end

-- function love.resize(w, h)
-- end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == "p" then 
        play = not play
    end
end

function love.update(dt)
    InputSystem:init()
    if play then
        myPlayer:update( dt )
        world:update(dt)
    end
end

function love.draw()
    if not play then
        menu:DrawMenu()
    else
       cam:attach()
            --
            Generator:DrawMap()
            -- myPlayer:draw()
            
            Draw()
            if isTreeAdded then
            elseif row <= Generator.h then
                Generator:AutoTiling(row)
                row = row + 1
            else
                Generator:AddTree()
                Generator:AddFlower()
                Generator:AddWafels()
                isTreeAdded = true
            end
            local r, g, b = love.graphics.getColor()
            love.graphics.setColor(0, 0, 0, 1)
            -- world:draw()
            love.graphics.setColor(r, g, b, 1)

        --     local x , y = myPlayer:GetPosition()
        --     x = x + 16 * scale
        --     y = y + 16
        --     love.graphics.circle('line', x, y, myPlayer.camera.radius)
            -- x, y = myPlayer:GetCameraPosition()
        --     love.graphics.circle('fill', x, y, 2)
        -- --
        cam:detach()
    end

    love.graphics.setColor(1,1,1,1)
end

--[[ 
    Ce fac azi: 
    * Inventar
    * Animale -- Incep cu o gaina
    * Realizez obiectele care pot cadea si sa fie luate
    * sa fac sa se poata de taiat copacii 
    * sa fac sa se prima constructie 
    * Inventar
    * Plasarea obiectelor
    * Sa pot merge doar pe pamanat -- implica generearea ge colidere
    * Aparitia plantelor -- Trebuie sa apara la inceput mai multe, dupa care sa creasca in ceva timp cate o planta
    * Constructie
    * Meniu 
    * Sound Efects
    
    -- reparat ******* Reparat normalizarea vectorului pentru a putea merge incet
    -- facut ********* pauza in joc

]]