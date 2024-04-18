local dgDrawing = {}

dgDrawing.dgLevel = require("Engine.dgLevel")

--marge d'affichage
dgDrawing.viewX = 0
dgDrawing.viewY = 0
--taille fenêtre d'affichage
dgDrawing.viewWidth = 200
dgDrawing.viewHeight = 200

dgDrawing.dgWidth = 0
dgDrawing.dgHeight = 0
dgDrawing.tailleCase = 10

dgDrawing.NORD = 1
dgDrawing.EST = 2
dgDrawing.SUD = 3
dgDrawing.OUEST = 4

function dgDrawing.changeCase(ligne, colonne, type)
   undo.addTask({"edit", thismaplv, ligne, colonne, dgLevel.map[ligne][colonne]})
   dungeon.changeCase(thismaplv, ligne, colonne, type)
end

function dgDrawing.load(lv)
end

function dgDrawing.draw2D(px, py)
   if not px then
      px = 0
   end
   if not py then
      py = 0
   end
   --
   for ligne = 1, dungeon.dgHeight do
      for colonne = 1, dungeon.dgWidth do
         local case = dungeon.dgLevel.map[ligne][colonne]
         local x = (colonne - 1) * dungeon.tailleCase
         local y = (ligne - 1) * dungeon.tailleCase

         if case >= 90 and case <= 99 then
            love.graphics.setColor(0.2, 0.1, 0.1)
         elseif case >= 10 and case <= 19 then
            love.graphics.setColor(0.5, 0, 0)
         elseif case >= 20 and case <= 29 then
            love.graphics.setColor(0.7, 0.2, 0)
         elseif case >= 30 and case <= 39 then
            love.graphics.setColor(0.5, 0.3, 0.3)
         elseif case >= 40 and case <= 49 then
            love.graphics.setColor(0.3, 0.3, 1)
         elseif case >= 50 and case <= 59 then
            love.graphics.setColor(0, 0.7, 0)
         elseif case >= 60 and case <= 69 then
            love.graphics.setColor(0, 1, 1)
         elseif case >= 70 and case <= 79 then
            love.graphics.setColor(1, 1, 0)
         end

         love.graphics.rectangle("fill", x + px, y + py, dungeon.tailleCase, dungeon.tailleCase)
         love.graphics.setColor(0, 0, 0)
         love.graphics.setLineWidth(.2)
         love.graphics.rectangle("line", x + px, y + py, dungeon.tailleCase, dungeon.tailleCase)
         love.graphics.setLineWidth(1)
      end
   end
end

function drawTexture(vertices, ligne, colonne, case)
   if case >= 10 and case < 90 then
      if case >= 10 and case <= 19 then
         love.graphics.setColor(0.5, 0.4, 0.4)
         drawPolygon(vertices)
      elseif case >= 20 and case <= 29 then
         love.graphics.setColor(0.7, 0.2, 0)
         drawPolygon(vertices)
      elseif case >= 30 and case <= 39 then
         love.graphics.setColor(0.5, 0.3, 0.3)
         drawPolygon(vertices)
      elseif case >= 40 and case <= 49 then
         love.graphics.setColor(0.3, 0.3, 1)
         drawPolygon(vertices)
      elseif case >= 50 and case <= 59 then
         love.graphics.setColor(0, 0.7, 0)
         drawPolygon(vertices)
      elseif case >= 60 and case <= 69 then
         love.graphics.setColor(0, 1, 1)
         drawPolygon(vertices)
      elseif case >= 70 and case <= 79 then
         love.graphics.setColor(1, 1, 0)
         drawPolygon(vertices)
      end
      drawShadow(ligne, colonne, vertices)
   end
end

function dgDrawing.draw(dt, mode, px, py)
   if mode == "2D" then
      dgDrawing.draw2D(px, py)
   elseif mode == "3D" then
      dgDrawing.draw3D()
   end
end

return dgDrawing
