local UIButton = {}

function btnDraw()

end

function btnUpdate() 

end

function creaBtn(x, y, imgDefault, imgHover, text) 

    local tab = {}
    tab.x = x
    tab.y = y
    tab.imgDefault = imgDefault
    tab.imgHover = imgHover
    tab.w = tab.imgDefault:getWidth()
    tab.h = tab.imgDefault:getHeight()
    tab.txt = text
    tab.hover = false
    tab.pressed = false

    -- Fonctions d'affichage et de mise à jour
    tab.draw = btnDraw
    tab.update = btnUpdate

    return tab
end

return UIButton
