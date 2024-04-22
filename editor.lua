local editor = {}
local name = "editor"
local editScale = 1
local translate = 5
local editedBlocs = {}

editor.blocType = ""

editor.canvas = canvas.create(name, 3, 53, 0, 1, 1, (wWidth / 2) - 7, wHeight - 57, 1, 1, 1, 1, "alpha")

function editor.inbound(ex, ey)
   return (ex > 0 and ex <= (dungeon.lvWidth * dungeon.tailleCase) and ey > 0 and
      ey <= (dungeon.lvHeight * dungeon.tailleCase))
end

function editor.getBlocType(case)
   if case >= 10 and case <= 12 then
      return "wall"
   elseif case >= 90 and case <= 92 then
      return "room"
   end
end

function editor.wall(ligne, colonne)
   local resultat = 0
   local loop = true

   while loop do
      resultat = love.math.random(10, 12)
      if editor.controlBlocs(resultat, ligne, colonne) then
         loop = false
      end
   end

   return resultat
   -- return math.random(10, 12)
end

function editor.room(ligne, colonne)
   local resultat = 0
   local loop = true

   while loop do
      resultat = love.math.random(90, 92)
      if editor.controlBlocs(resultat, ligne, colonne) then
         loop = false
      end
   end

   return resultat
   -- return math.random(90, 92)
end

function editor.controlBlocs(casetype, ligne, colonne)
   if
      dungeon.case(thismaplv, ligne - 2, colonne) == casetype and
         dungeon.case(thismaplv, ligne - 1, colonne) == casetype
    then
      return false
   elseif
      dungeon.case(thismaplv, ligne + 2, colonne) == casetype and
         dungeon.case(thismaplv, ligne + 1, colonne) == casetype
    then
      return false
   elseif
      dungeon.case(thismaplv, ligne, colonne - 2) == casetype and
         dungeon.case(thismaplv, ligne, colonne - 1) == casetype
    then
      return false
   elseif
      dungeon.case(thismaplv, ligne, colonne + 2) == casetype and
         dungeon.case(thismaplv, ligne, colonne + 1) == casetype
    then
      return false
   end
   return true
end

function editor.load()
   if thismaplv ~= 0 then
      dungeon.loadLevel(thismaplv)
   end
   blocType = "room"
end

function editor.canvas.update(self, dt)
   --Draw inside
   love.graphics.scale(editScale, editScale)
   dgDrawing.draw(dt, "2D", 5, 5)
   love.graphics.scale(1, 1)
end

function editor.update(dt)
   editor.canvas:updateDraw(dt)

   local ex = ((mx - editor.canvas.x) / editScale) - translate
   local ey = ((my - editor.canvas.y) / editScale) - translate

   if love.mouse.isDown(1) then
      if editor.inbound(ex, ey) then
         local ligne = math.floor(ey / dungeon.tailleCase) + 1
         local colonne = math.floor(ex / dungeon.tailleCase) + 1
         local thiscase = dungeon.case(thismaplv, ligne, colonne)
         if editor.getBlocType(thiscase) ~= "room" then
            local casetype = editor.room(ligne, colonne)
            dgDrawing.changeCase(ligne, colonne, casetype)
            addTask({undoIndex + 1, "edit", thismaplv, ligne, colonne, thiscase})
         end
      end
   elseif love.mouse.isDown(2) then
      if editor.inbound(ex, ey) then
         local ligne = math.floor(ey / dungeon.tailleCase) + 1
         local colonne = math.floor(ex / dungeon.tailleCase) + 1
         local thiscase = dungeon.case(thismaplv, ligne, colonne)
         if editor.getBlocType(thiscase) ~= "wall" then
            local casetype = editor.wall(ligne, colonne)
            dgDrawing.changeCase(ligne, colonne, casetype)
            addTask({undoIndex + 1, "edit", thismaplv, ligne, colonne, thiscase})
         end
      end
   end
end

function editor.draw()
   editor.canvas:draw()
end

function editor.keypressed(key)
end

function editor.mousepressed(button, istouch)
   if button == 3 then
      editScale = 1
   end
end

function editor.wheelmoved(wx, wy)
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

return editor
