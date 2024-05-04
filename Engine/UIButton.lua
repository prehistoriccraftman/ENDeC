local uiButton = {}

function uiButton.btnDraw()
end

function uiButton.btnUpdate()
end

function uiButton.creaBtn(x, y, imgDefault, imgClicked, imgError, imgOk, text)
   local tab = {}
   tab.x = x
   tab.y = y
   tab.imgDefault = imgDefault
   tab.imgClicked = imgHover
   tab.imgError = imgError
   tab.imgOk = imgOk
   tab.w = tab.imgDefault:getWidth()
   tab.h = tab.imgDefault:getHeight()
   tab.txt = text
   tab.pressed = false

   -- Fonctions d'affichage et de mise à jour
   tab.draw = btnDraw
   tab.update = btnUpdate

   return tab
end

return uiButton
