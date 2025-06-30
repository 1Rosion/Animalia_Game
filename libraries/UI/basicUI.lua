-- UI = {}

-- function UI: new()
--     local obj = {}

--     obj.children = {}

-- end

-- function UI: draw() end
-- function UI: click() end
-- function UI: hover() end







UIelement = {}

-- elementul principal din design
local root = {
    children = {}
}

function UIelement: new(x, y)
    local obj = {}
    
    obj.pos = Vector2:new(x or 0, y or 0)

end


function UIelement: draw() end
function UIelement: click() end
function UIelement: hover() end

