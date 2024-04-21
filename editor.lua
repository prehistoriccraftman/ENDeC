local editor = {}
local name = "editor"
local editScale = 1
local translate = 5
local editType = 0

editor.canvas = canvas.create(name, 3, 53, 0, 1, 1, (wWidth / 2) - 7, wHeight - 57, 1, 1, 1, 1, "alpha")

function editor.canvas.update(self, dt)
   -- wZoom:update()

   --Draw inside
   love.graphics.scale(editScale, editScale)
   dgDrawing.draw(dt, "2D", translate, translate)
   love.graphics.scale(1, 1)
end

function editor.load()
   if thismaplv ~= 0 then
      dungeon.loadLevel(thismaplv)
   end
   editType = math.random(10, 13)
end

function editor.update(dt)
   editor.canvas:updateDraw(dt)
end

function editor.draw()
   editor.canvas:draw()
end

function editor.keypressed(key)
end

function editor.mousepressed(button, istouch)
   if inbound() then
      focus = "editor"
      print(focus)
      if button == 3 then
         editScale = 1
      end
   end
       mx = (mx / editScale) - translate
    my = (my / editScale) - translate
    if mbutton == 1 then
        if
            mx >= translate and mx <= (translate + dgDrawing.dgWidth * dgDrawing.tailleCase) and my >= translate and
                my <= (translate + dgDrawing.dgHeight * dgDrawing.tailleCase)
         then
            local ligne = math.floor(my / dgDrawing.tailleCase) + 1
            local colonne = math.floor(mx / dgDrawing.tailleCase) + 1
            --
            dgDrawing.changeCase(ligne, colonne, editType)
            addTask({undoIndex + 1, "add", ligne, colonne, type)
        end
    elseif mbutton == 2 then
        if
            mx >= translate and mx <= (translate + dgDrawing.dgWidth * dgDrawing.tailleCase) and my >= translate and
                my <= (translate + dgDrawing.dgHeight * dgDrawing.tailleCase)
         then
            local ligne = math.floor(my / dgDrawing.tailleCase) + 1
            local colonne = math.floor(mx / dgDrawing.tailleCase) + 1
            --
            dgDrawing.changeCase(ligne, colonne, math.random(90, 93))
        end
    end
end

function editor.wheelmoved(wx, wy)
   if inbound() then
      -- love.graphics.translate(-mx,-my)
      if wy > 0 then
         editScale = editScale * 1.1
         if editScale > 5 then
            editScale = 5
         end
      elseif wy < 0 then
         editScale = editScale * 0.9
         if editScale < 0.5 then
            editScale = 0.5
         end
      end
   end
end

function inbound()
   if mx > editor.canvas.x and my > editor.canvas.y and mx < editor.canvas.w and my < editor.canvas.h then
      return true
   end
   return false
end

return editor
