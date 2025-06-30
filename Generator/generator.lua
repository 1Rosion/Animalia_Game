--[[
    AutoTiling {
        Se verifica numarul de vecini si locaul acestora, dupa care se formeaza un cod.
        Codul reprezinta insusi numarul si pozitia vecinilor, in dependenta de cod i se 
        atribuie un anumit sprite. 

        Metoda economiseste putere de procesare prin ceea ca nu verifica fiecare sprite,
        nu se folosesc coditii ci doar un Dictionar cu spriteuri care primeste ca cheie
        codul creat de aplicatoe.
    }
]]

local data = {
    lakeExpansionChance = 0.4,  -- 0
    -- ground                   -- 1
    treeChance = 0.2,           -- 2
    flowerChance = 0.1,         -- 3
    bushChance = 0.05,          -- 4
}


Generator = {
    w = 100,
    h = 100,
    map = {}, -- 0/1 pamant apa
    mapPlants = nil,
    toDrawMap = {},
    grassSpites2 = {
        ["0011"] = Sprite:new("Resource/Tiles/Grass.png", 0 , 0, 16, 16, 1, 100),
        ["0111"] = Sprite:new("Resource/Tiles/Grass.png", 16, 0, 16, 16, 1, 100),
        ["0101"] = Sprite:new("Resource/Tiles/Grass.png", 32, 0, 16, 16, 1, 100),
        ["1011"] = Sprite:new("Resource/Tiles/Grass.png", 0 , 16, 16, 16, 1, 100),
        ["1111"] = Sprite:new("Resource/Tiles/Grass.png", 16, 16, 16, 16, 1, 100),
        ["1101"] = Sprite:new("Resource/Tiles/Grass.png", 32, 16, 16, 16, 1, 100),
        ["1010"] =  Sprite:new("Resource/Tiles/Grass.png", 0 , 32, 16, 16, 1, 100),
        ["1110"] = Sprite:new("Resource/Tiles/Grass.png", 16, 32, 16, 16, 1, 100),
        ["1100"] = Sprite:new("Resource/Tiles/Grass.png", 32, 32, 16, 16, 1, 100),
        ["0001"] = Sprite:new("Resource/Tiles/Grass.png", 48, 0, 16, 16, 1, 100),
        ["1001"] = Sprite:new("Resource/Tiles/Grass.png", 48, 16, 16, 16, 1, 100),
        ["1000"] = Sprite:new("Resource/Tiles/Grass.png", 48, 32, 16, 16, 1, 100),
        ["0010"] = Sprite:new("Resource/Tiles/Grass.png", 0 , 48, 16, 16, 1, 100),
        ["0110"] = Sprite:new("Resource/Tiles/Grass.png", 16, 48, 16, 16, 1, 100),
        ["0100"] = Sprite:new("Resource/Tiles/Grass.png", 32, 48, 16, 16, 1, 100),
        ["0000"] = Sprite:new("Resource/Tiles/Grass.png", 48, 48, 16, 16, 1, 100),
        ["00001010"] = Sprite:new("Resource/Tiles/Grass.png", 64, 0, 16, 16, 1, 100),
        ["00011011"] = Sprite:new("Resource/Tiles/Grass.png", 96, 0, 16, 16, 1, 100),
        ["00011110"] = Sprite:new("Resource/Tiles/Grass.png", 80, 0, 16, 16, 1, 100),
        ["10011110"] = Sprite:new("Resource/Tiles/Grass.png", 80, 0, 16, 16, 1, 100),
        ["10111110"] = Sprite:new("Resource/Tiles/Grass.png", 80, 0, 16, 16, 1, 100),
        ["00111110"] = Sprite:new("Resource/Tiles/Grass.png", 80, 0, 16, 16, 1, 100),
        ["00010010"] = Sprite:new("Resource/Tiles/Grass.png", 112, 0, 16, 16, 1, 100),
        ["00010011"] = Sprite:new("Resource/Tiles/Grass.png", 112, 0, 16, 16, 1, 100),
        ["10010010"] = Sprite:new("Resource/Tiles/Grass.png", 112, 0, 16, 16, 1, 100),
        ["10010011"] = Sprite:new("Resource/Tiles/Grass.png", 112, 0, 16, 16, 1, 100),
        ["00011010"] = Sprite:new("Resource/Tiles/Grass.png", 128, 0, 16, 16, 1, 100),
        ["10011010"] = Sprite:new("Resource/Tiles/Grass.png", 128, 0, 16, 16, 1, 100),
        ["00111010"] = Sprite:new("Resource/Tiles/Grass.png", 128, 0, 16, 16, 1, 100),
        ["10111010"] = Sprite:new("Resource/Tiles/Grass.png", 128, 0, 16, 16, 1, 100),
        ["01001010"] = Sprite:new("Resource/Tiles/Grass.png", 64, 64, 16, 16, 1, 100),
        ["01001011"] = Sprite:new("Resource/Tiles/Grass.png", 64, 32, 16, 16, 1, 100),
        ["11001111"] = Sprite:new("Resource/Tiles/Grass.png", 64, 32, 16, 16, 1, 100),
        ["11001011"] = Sprite:new("Resource/Tiles/Grass.png", 64, 32, 16, 16, 1, 100),
        ["01001111"] = Sprite:new("Resource/Tiles/Grass.png", 64, 32, 16, 16, 1, 100),
        ["11101010"] = Sprite:new("Resource/Tiles/Grass.png", 64, 16, 16, 16, 1, 100),
        ["01101010"] = Sprite:new("Resource/Tiles/Grass.png", 64, 16, 16, 16, 1, 100),
        ["01011000"] = Sprite:new("Resource/Tiles/Grass.png", 128, 48, 16, 16, 1, 100),
        ["01111000"] = Sprite:new("Resource/Tiles/Grass.png", 96, 48, 16, 16, 1, 100),
        ["01111001"] = Sprite:new("Resource/Tiles/Grass.png", 96, 48, 16, 16, 1, 100),
        ["11011000"] = Sprite:new("Resource/Tiles/Grass.png", 80, 48, 16, 16, 1, 100),
        ["11011100"] = Sprite:new("Resource/Tiles/Grass.png", 80, 48, 16, 16, 1, 100),
        ["01011010"] = Sprite:new("Resource/Tiles/Grass.png", 128, 64, 16, 16, 1, 100),
        ["01011011"] = Sprite:new("Resource/Tiles/Grass.png", 144, 32, 16, 16, 1, 100),
        ["01011110"] = Sprite:new("Resource/Tiles/Grass.png", 160, 32, 16, 16, 1, 100),
        ["01111010"] = Sprite:new("Resource/Tiles/Grass.png", 144, 48, 16, 16, 1, 100),
        ["11011010"] = Sprite:new("Resource/Tiles/Grass.png", 160, 48, 16, 16, 1, 100),
        ["01111110"] = Sprite:new("Resource/Tiles/Grass.png", 144, 0, 16, 16, 1, 100),
        ["11011011"] = Sprite:new("Resource/Tiles/Grass.png", 144, 16, 16, 16, 1, 100),
        ["11111010"] = Sprite:new("Resource/Tiles/Grass.png", 128, 16, 16, 16, 1, 100),
        ["01011111"] = Sprite:new("Resource/Tiles/Grass.png", 128, 32, 16, 16, 1, 100),
        ["11011110"] = Sprite:new("Resource/Tiles/Grass.png", 80, 64, 16, 16, 1, 100),
        ["01111011"] = Sprite:new("Resource/Tiles/Grass.png", 96, 64, 16, 16, 1, 100),
        ["01111111"] = Sprite:new("Resource/Tiles/Grass.png", 96, 32, 16, 16, 1, 100),
        ["11011111"] = Sprite:new("Resource/Tiles/Grass.png", 80, 32, 16, 16, 1, 100),
        ["11111011"] = Sprite:new("Resource/Tiles/Grass.png", 96, 16, 16, 16, 1, 100),
        ["11111110"] = Sprite:new("Resource/Tiles/Grass.png", 80, 16, 16, 16, 1, 100),
        ["01001000"] = Sprite:new("Resource/Tiles/Grass.png", 64, 48, 16, 16, 1, 100),
        ["01001001"] = Sprite:new("Resource/Tiles/Grass.png", 64, 48, 16, 16, 1, 100),
        ["01010010"] = Sprite:new("Resource/Tiles/Grass.png", 112, 64, 16, 16, 1, 100),
        ["01010011"] = Sprite:new("Resource/Tiles/Grass.png", 112, 64, 16, 16, 1, 100),
        ["01010110"] = Sprite:new("Resource/Tiles/Grass.png", 112, 32, 16, 16, 1, 100),
        ["01010111"] = Sprite:new("Resource/Tiles/Grass.png", 112, 32, 16, 16, 1, 100),
        ["11010010"] = Sprite:new("Resource/Tiles/Grass.png", 112, 16, 16, 16, 1, 100),
        ["11010011"] = Sprite:new("Resource/Tiles/Grass.png", 112, 16, 16, 16, 1, 100),
        ["01010000"] = Sprite:new("Resource/Tiles/Grass.png", 112, 48, 16, 16, 1, 100),
        ["01010100"] = Sprite:new("Resource/Tiles/Grass.png", 112, 48, 16, 16, 1, 100)
    },
}

function Generator:newMap(w, h, seed)
    self.map = {}
    self.w = w or 100
    self.h = h or 100

    math.randomseed(seed or 12345) -- Daca nu a fost setat seed-ul atunci se pune pe cel default: 12345

    for i = 1, self.w do -- umple tabelul cu elemente de pamant (pamant : 1)
        table.insert(self.map, {})
        for j = 1, self.h do
            table.insert(self.map[i], 1)
        end
    end

    self:AddWater()
end

function Generator:AddWater()
    local lakeNumber = math.floor(math.random((self.w + self.h) / 4))

    for i = 1, lakeNumber do
        -- Selectează o locație inițială pentru lac
        local x, y = math.floor(math.random(self.w)), math.floor(math.random(self.h))
        self.map[x][y] = 0 -- Marchează punctul inițial ca apă

        -- Extindere lac
        local expansionChance = data.lakeExpansionChance -- Probabilitatea de extindere
        local directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}} -- Direcții posibile: dreapta, jos, stânga, sus
        local frontier = {{x, y}} -- Frontieră pentru extindere

        while #frontier > 0 do
            -- Selectează și elimină un punct din frontieră
            local index = math.random(1, #frontier)
            local current = table.remove(frontier, index)

            -- Pentru fiecare direcție, încearcă să extindă lacul
            for _, dir in ipairs(directions) do
                local nx, ny = current[1] + dir[1], current[2] + dir[2]

                -- Verifică limitele hărții și probabilitatea de extindere
                if nx > 0 and nx <= self.w and ny > 0 and ny <= self.h and math.random() < expansionChance then
                    if self.map[nx][ny] ~= 0 then -- Dacă nu e deja apă
                        self.map[nx][ny] = 0
                        table.insert(frontier, {nx, ny}) -- Adaugă punctul extins la frontieră
                    end
                end
            end
        end
    end
end

function Generator:AutoTiling(row)
    table.insert(self.toDrawMap, row, {})

    for i, x in ipairs(self.map[row]) do
        if x == 1 then
            local points = {}
            table.insert(points, math.floor(((self.map[row - 1] or {})[i - 1] or 0)))
            table.insert(points, math.floor(((self.map[row - 1] or {})[i] or 0)))
            table.insert(points, math.floor(((self.map[row - 1] or {})[i + 1] or 0)))
            table.insert(points, math.floor((self.map[row][i - 1] or 0)))
            table.insert(points, math.floor((self.map[row][i + 1] or 0)))
            table.insert(points, math.floor(((self.map[row + 1] or {})[i -1] or 0)))
            table.insert(points, math.floor(((self.map[row + 1] or {})[i] or 0)))
            table.insert(points, math.floor(((self.map[row + 1] or {})[i + 1] or 0)))

            local index8bytes = ""
            local index4bytes = points[2] .. points[4] .. points[5] .. points[7]

            for j = 1, 8 do
                index8bytes = index8bytes .. points[j]
            end

            if self.grassSpites2[index8bytes] then
                table.insert(self.toDrawMap[row], index8bytes)
            else
                table.insert(self.toDrawMap[row], index4bytes)
            end
        else
                table.insert(self.toDrawMap[row], 0)
        end
    end

    return
end

function Generator:DrawMap()
    for x, i in ipairs(self.toDrawMap) do
        for y, j in ipairs(i) do
            if self.grassSpites2[j] then
                self.grassSpites2[j]:draw(32 * y * scale , 32 * x * scale,  0, 2 * scale)
            end
        end
    end
end

---- Functia adauga elementele de tip copaci in lume, elementele initiale
function Generator:AddTree()
    Generator.mapPlants = Generator.mapPlants or Generator.map

    for x, row in ipairs(Generator.mapPlants) do
        for y, cell in ipairs(row) do
            if cell == 1 and math.random() < data.treeChance then
                Generator.mapPlants[x][y] = 2
                -- cell = 2

                Tree:new((32 * y + 16) * scale, (32 * x + 16) * scale + 16)
            end
        end
    end
end

function Generator:AddFlower()
    Generator.mapPlants = Generator.mapPlants or Generator.toDrawMap

    for x, row in ipairs(Generator.mapPlants) do
        for y, cell in ipairs(row) do
            if cell == 1 and math.random() < data.flowerChance then
                Generator.mapPlants[x][y] = 2


                Flower:new(32 * y * scale, 32 * x * scale)
            end
        end
    end
end

function Generator:AddWafels()
    Generator.mapPlants = Generator.mapPlants or Generator.map

    for x, row in ipairs(Generator.mapPlants) do
        for y, cell in ipairs(row) do
            if cell == 1 and math.random() < data.flowerChance then
                Generator.mapPlants[x][y] = 2
                -- cell = 2

                Wafels:new(32 * y * scale, 32 * x * scale)
            end
        end
    end
end

-- grassSpites = {
    --     [100] = Sprite:new("Resource/Tiles/Grass.png", 0 , 0, 16, 16, 1, 0),
    --     [101] = Sprite:new("Resource/Tiles/Grass.png", 0 , 0, 16, 16, 1, 100),
    --     [102] = Sprite:new("Resource/Tiles/Grass.png", 16, 0, 16, 16, 1, 100),
    --     [103] = Sprite:new("Resource/Tiles/Grass.png", 32, 0, 16, 16, 1, 100),
    --     [104] = Sprite:new("Resource/Tiles/Grass.png", 0 , 16, 16, 16, 1, 100),
    --     [105] = Sprite:new("Resource/Tiles/Grass.png", 16, 16, 16, 16, 1, 100),
    --     [106] = Sprite:new("Resource/Tiles/Grass.png", 32, 16, 16, 16, 1, 100),
    --     [107] =  Sprite:new("Resource/Tiles/Grass.png", 0 , 32, 16, 16, 1, 100),
    --     [108] = Sprite:new("Resource/Tiles/Grass.png", 16, 32, 16, 16, 1, 100),
    --     [109] = Sprite:new("Resource/Tiles/Grass.png", 32, 32, 16, 16, 1, 100),
    --     [110] = Sprite:new("Resource/Tiles/Grass.png", 48, 0, 16, 16, 1, 100),
    --     [111] = Sprite:new("Resource/Tiles/Grass.png", 48, 16, 16, 16, 1, 100),
    --     [112] = Sprite:new("Resource/Tiles/Grass.png", 48, 32, 16, 16, 1, 100),
    --     [113] = Sprite:new("Resource/Tiles/Grass.png", 0 , 48, 16, 16, 1, 100),
    --     [114] = Sprite:new("Resource/Tiles/Grass.png", 16, 48, 16, 16, 1, 100),
    --     [115] = Sprite:new("Resource/Tiles/Grass.png", 32, 48, 16, 16, 1, 100),
    --     [116] = Sprite:new("Resource/Tiles/Grass.png", 48, 48, 16, 16, 1, 100),
    --     [117] = Sprite:new("Resource/Tiles/Grass.png", 64, 0, 16, 16, 1, 100),
    --     [118] = Sprite:new("Resource/Tiles/Grass.png", 96, 0, 16, 16, 1, 100),
    --     [119] = Sprite:new("Resource/Tiles/Grass.png", 80, 0, 16, 16, 1, 100),
    --     [120] = Sprite:new("Resource/Tiles/Grass.png", 112, 0, 16, 16, 1, 100),
    --     [121] = Sprite:new("Resource/Tiles/Grass.png", 128, 0, 16, 16, 1, 100),
    --     [122] = Sprite:new("Resource/Tiles/Grass.png", 64, 64, 16, 16, 1, 100),
    --     [123] = Sprite:new("Resource/Tiles/Grass.png", 64, 32, 16, 16, 1, 100),
    --     [124] = Sprite:new("Resource/Tiles/Grass.png", 64, 16, 16, 16, 1, 100),
    --     [125] = Sprite:new("Resource/Tiles/Grass.png", 128, 48, 16, 16, 1, 100),
    --     [126] = Sprite:new("Resource/Tiles/Grass.png", 96, 48, 16, 16, 1, 100),
    --     [127] = Sprite:new("Resource/Tiles/Grass.png", 80, 48, 16, 16, 1, 100),
    --     [129] = Sprite:new("Resource/Tiles/Grass.png", 128, 64, 16, 16, 1, 100),
    --     [130] = Sprite:new("Resource/Tiles/Grass.png", 144, 32, 16, 16, 1, 100),
    --     [131] = Sprite:new("Resource/Tiles/Grass.png", 160, 32, 16, 16, 1, 100),
    --     [132] = Sprite:new("Resource/Tiles/Grass.png", 144, 48, 16, 16, 1, 100),
    --     [133] = Sprite:new("Resource/Tiles/Grass.png", 160, 48, 16, 16, 1, 100),
    --     [134] = Sprite:new("Resource/Tiles/Grass.png", 144, 0, 16, 16, 1, 100),
    --     [135] = Sprite:new("Resource/Tiles/Grass.png", 144, 16, 16, 16, 1, 100),
    --     [136] = Sprite:new("Resource/Tiles/Grass.png", 128, 16, 16, 16, 1, 100),
    --     [137] = Sprite:new("Resource/Tiles/Grass.png", 128, 32, 16, 16, 1, 100),
    --     [138] = Sprite:new("Resource/Tiles/Grass.png", 80, 64, 16, 16, 1, 100),
    --     [139] = Sprite:new("Resource/Tiles/Grass.png", 96, 64, 16, 16, 1, 100),
    --     [140] = Sprite:new("Resource/Tiles/Grass.png", 96, 32, 16, 16, 1, 100),
    --     [141] = Sprite:new("Resource/Tiles/Grass.png", 80, 32, 16, 16, 1, 100),
    --     [142] = Sprite:new("Resource/Tiles/Grass.png", 96, 16, 16, 16, 1, 100),
    --     [143] = Sprite:new("Resource/Tiles/Grass.png", 80, 16, 16, 16, 1, 100),
    --     [144] = Sprite:new("Resource/Tiles/Grass.png", 64, 48, 16, 16, 1, 100),
    --     [147] = Sprite:new("Resource/Tiles/Grass.png", 112, 64, 16, 16, 1, 100),
    --     [148] = Sprite:new("Resource/Tiles/Grass.png", 112, 32, 16, 16, 1, 100),
    --     [149] = Sprite:new("Resource/Tiles/Grass.png", 112, 16, 16, 16, 1, 100),
    --     [150] = Sprite:new("Resource/Tiles/Grass.png", 112, 48, 16, 16, 1, 100),
    -- },

-- function Generator:AutoTiling2(row)
--     for i, x in ipairs(self.map[row]) do
--         local v1 = math.floor(((self.map[row - 1] or {})[i - 1] or 3))
--         local v2 = math.floor(((self.map[row - 1] or {})[i] or 3))
--         local v3 = math.floor(((self.map[row - 1] or {})[i + 1] or 3))
--         local v4 = math.floor((self.map[row][i - 1] or 3))
--         local v5 = math.floor((self.map[row][i + 1] or 3))
--         local v6 = math.floor(((self.map[row + 1] or {})[i -1] or 3))
--         local v7 = math.floor(((self.map[row + 1] or {})[i] or 3))
--         local v8 = math.floor(((self.map[row + 1] or {})[i + 1] or 3))

--         if x == 1 then
--             if v2 ~= 1 and v4 ~= 1 and v5 == 1 and v7 == 1 then
--                 self.map[row][i] = 1.01
--                 if v8 ~= 1 then
--                     self.map[row][i] = 1.17
--                 end
--             elseif v2 ~= 1 and v4 == 1 and v5 == 1 and v7 == 1 then
--                 self.map[row][i] = 1.02
--                 if v6 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.21
--                 elseif v6 ~= 1 then
--                     self.map[row][i] = 1.18
--                 elseif v8 ~= 1 then 
--                     self.map[row][i] = 1.19
--                 end
--             elseif v2 ~= 1 and v4 == 1 and v5 ~= 1 and v7 == 1 then
--                 self.map[row][i] = 1.03
--                 if v6 ~= 1 then
--                     self.map[row][i] = 1.2
--                 end
--             elseif v2 == 1 and v4 ~= 1 and v5 == 1 and v7 == 1 then
--                 self.map[row][i] = 1.04
--                 if v3 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.22
--                 elseif v3 ~= 1 then
--                     self.map[row][i] = 1.23
--                 elseif v8 ~= 1 then
--                     self.map[row][i] = 1.24
--                 end
--             elseif v2 == 1 and v4 == 1 and v5 == 1 and v7 == 1 then
--                 if v1 == 1 and v3 == 1 and v6 == 1 and v8 == 1 then
--                     self.map[row][i] = 1.05
--                 elseif v1 ~= 1 and v3 ~= 1 and v6 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.29
--                 elseif v1 ~= 1 and v3 ~= 1 and v6 ~= 1 then
--                     self.map[row][i] = 1.3
--                 elseif v1 ~= 1 and v3 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.31
--                 elseif v1 ~= 1 and v6 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.32
--                 elseif v3 ~= 1 and v6 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.33
--                 elseif v1 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.34
--                 elseif v3 ~= 1 and v6 ~= 1 then
--                     self.map[row][i] = 1.35
--                 elseif v6 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.36
--                 elseif v1 ~= 1 and v3 ~= 1 then
--                     self.map[row][i] = 1.37
--                 elseif v3 ~= 1 and v8 ~= 1 then
--                     self.map[row][i] = 1.38
--                 elseif v1 ~= 1 and v6 ~= 1 then
--                     self.map[row][i] = 1.39
--                 elseif v1 ~= 1 then
--                     self.map[row][i] = 1.4
--                 elseif v3 ~= 1 then
--                     self.map[row][i] = 1.41
--                 elseif v6 ~= 1 then
--                     self.map[row][i] = 1.42
--                 elseif v8 ~= 1 then
--                     self.map[row][i] = 1.43
--                 end
--             elseif v2 == 1 and v4 == 1 and v5 ~= 1 and v7 == 1 then
--                 self.map[row][i] = 1.06
--                 if v1 ~= 1 and v6 ~= 1 then
--                     self.map[row][i] = 1.47
--                 elseif v1 ~= 1 then
--                     self.map[row][i] = 1.48
--                 elseif v6 ~= 1 then
--                     self.map[row][i] = 1.49
--                 end
--             elseif v2 == 1 and v4 ~= 1 and v5 == 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.07
--                 if v3 ~= 1 then
--                     self.map[row][i] = 1.44
--                 end
--             elseif v2 == 1 and v4 == 1 and v5 == 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.08
--                 if v1 ~= 1 and v3 ~= 1 then
--                     self.map[row][i] = 1.25
--                 elseif v1 ~= 1 then
--                     self.map[row][i] = 1.26
--                 elseif v3 ~= 1 then
--                     self.map[row][i] = 1.27
--                 end
--             elseif v2 == 1 and v4 == 1 and v5 ~= 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.09
--                 if v1 ~= 1 then
--                     self.map[row][i] = 1.5
--                 end
--             elseif v2 ~= 1 and v4 ~= 1 and v5 ~= 1 and v7 == 1 then
--                 self.map[row][i] = 1.1
--             elseif v2 == 1 and v4 ~= 1 and v5 ~= 1 and v7 == 1 then
--                 self.map[row][i] = 1.11
--             elseif v2 == 1 and v4 ~= 1 and v5 ~= 1 and v7 ~= 1 then
--                 self.map[row][i]  = 1.12
--             elseif v2 ~= 1 and v4 ~= 1 and v5 == 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.13
--             elseif v2 ~= 1 and v4 == 1 and v5 == 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.14
--             elseif v2 ~= 1 and v4 == 1 and v5 ~= 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.15
--             elseif v2 ~= 1 and v4 ~= 1 and v5 ~= 1 and v7 ~= 1 then
--                 self.map[row][i] = 1.16
--             end
--         end
--     end
-- end