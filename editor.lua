local editor = {}
local name = "editor"
local editScale = 1
local translate = 5
local editType = 0

editor.canvas = canvas.create(name, 3, 53, 0, 1, 1, (wWidth / 2) - 7, wHeight - 57, 1, 1, 1, 1, "alpha")

function editor.load()
   if thismaplv ~= 0 then
      dungeon.loadLevel(thismaplv)
   end
end

function editor.canvas.update(self, dt)
   --Draw inside
   love.graphics.scale(editScale, editScale)
   dgDrawing.draw(dt, "2D", 5, 5)
   love.graphics.scale(1, 1)
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
   if focus() == "editor" then
      print(focusOn)
      if button == 3 then
         editScale = 1
      end
   end

   local ex = ((mx - editor.canvas.x) / editScale) - translate
   local ey = ((my - editor.canvas.y) / editScale) - translate

   if button == 1 then
      if
         ex >= translate and ex <= (translate + dungeon.lvWidth * dungeon.tailleCase) and ey >= translate and
            ey <= (translate + dungeon.lvHeight * dungeon.tailleCase)
       then
         editType = math.random(10, 12)
         local ligne = math.floor(ey / dungeon.tailleCase) + 1
         local colonne = math.floor(ex / dungeon.tailleCase) + 1
         dgDrawing.changeCase(ligne, colonne, editType)
      end
   elseif button == 2 then
      if
         ex >= translate and ex <= (translate + dungeon.lvWidth * dungeon.tailleCase) and ey >= translate and
            ey <= (translate + dungeon.lvHeight * dungeon.tailleCase)
       then
         editType = math.random(90, 92)
         local ligne = math.floor(ey / dungeon.tailleCase) + 1
         local colonne = math.floor(ex / dungeon.tailleCase) + 1
         dgDrawing.changeCase(ligne, colonne, editType)
      end
   end
end

function editor.wheelmoved(wx, wy)
   if focus() == "editor" then
      print(focusOn)
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

return editor
