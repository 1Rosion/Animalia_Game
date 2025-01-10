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

VisualElement = {}

function VisualElement:new(sprite, zIndex, draw) -- Element vizual de baza, acest element se va folosit pentru afisarea si sortarea elementelor vizuale 
    local obj = {}

    obj.pos = Vector2:new(0, 0) -- pozitia de afisare a spriturilor
    obj.pivotY = 0 -- pozitia dupa care se compara Elementele vizuale

    obj.isVisible = true -- valoare booleana care determina daca este vizibil elementul

    obj.sprite = sprite or Sprite:new("Resource/Animals/Chicken/Chicken.png", 0, 0, 16, 16, 2, 0.2) -- Imaginea de afisare
    obj.zIndex = zIndex or 0 -- Ordinea de afisare a elementelor

    obj.draw = draw or function () return false end

    setmetatable(obj, self)
    self.__index = self

    if not VisualElements[zIndex] then
        table.insert(VisualElements, zIndex, {})
    end
    table.insert(VisualElements[zIndex], obj)

    return obj
end

-- function VisualElement:CompareElements(ve1, ve2)
--     local pivotPos1 = ve1.pos.y + ve1.pivotY
--     local pivotPos2 = ve2.pos.y + ve2.pivotY

--     if pivotPos1 > pivotPos2 then
--         return -1
--     elseif pivotPos1 < pivotPos2 then
--         return 1
--     else
--         return 0
--     end
-- end

function VisualElement:ChangeZIndex(newZIndex)
    local zIndex = self.zIndex
    self.zIndex = newZIndex

    if not VisualElements[newZIndex] then
        table.insert(VisualElements, newZIndex, {})
    end

    table.remove(VisualElements[zIndex], self)

    table.insert(VisualElements[newZIndex], self)

    if #VisualElements[zIndex] == 0 then
        
    end
end

VisualElements = {} -- tabel cu elemente de grafica, se va folosi la sortare si afisare
-- Pentru fiecare index exista un nou tabel

function VisualSort(zIndex) -- Sorteaza anume pentru un index, evit sortarea tuturor pentru a micsora cheltuelile de resurse
    local f = true -- Controll variable

    while f do
        f = false
        for i = 1, #VisualElements[zIndex] - 1 do
            local pivotPos1 = VisualElements[zIndex][i].pos.y + VisualElements[zIndex][i].pivotY
            local pivotPos2 = VisualElements[zIndex][i + 1].pos.y + VisualElements[zIndex][i + 1].pivotY

            if pivotPos1 > pivotPos2 then
                local auxiliar = VisualElements[zIndex][i]
                VisualElements[zIndex][i] = VisualElements[zIndex][i + 1]
                VisualElements[zIndex][i + 1] = auxiliar

                f = true
            end
        end
    end
end

function Draw()
    for _, zIndex in pairs(VisualElements) do
        for i = 1, #zIndex do
            if not zIndex[i].draw() then
                if zIndex[i].isVisible then
                    zIndex[i].sprite:draw(zIndex[i].pos.x, zIndex[i].pos.y, 0, scale)
                end
            end

            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.circle("fill", zIndex[i].pos.x, zIndex[i].pos.y + zIndex[i].pivotY, 2)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

