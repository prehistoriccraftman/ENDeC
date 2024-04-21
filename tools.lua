local tools = {}
local name = "tools"

tools.canvas = canvas.create(name, wWidth / 2, 54, 0, 1, 1, wWidth / 2, wHeight - 50, 1, 1, 1, 1, "alpha")

function tools.canvas.update(self, dt) -- override appelé dans --> updateDraw()
   love.graphics.setColor(0, 0, 0, 1)
   love.graphics.print(tools.canvas.name, 10, 10)
end

function tools.load()
end

function tools.update(dt)
   tools.canvas:updateDraw(dt)
end

function tools.draw(dt)
   tools.canvas:draw()
end

function tools.keypressed(key)
   if thismaplv ~= 0 then
      if key == "left" then --on se positionne sur la carte précédente
         thismaplv = thismaplv - 1
         if thismaplv < 1 then --contrôle si on est au début
            thismaplv = 1
         end
      elseif key == "right" then --on se positionne sur la carte suivante
         thismaplv = thismaplv + 1
         if thismaplv > #dungeon.levels then --contrôle si on est au max
            thismaplv = #dungeon.levels
         end
      elseif key == "pageup" then --on se positionne sur la dernière carte
         thismaplv = #dungeon.levels
      elseif key == "pagedown" then --on se positionne sur la première carte
         thismaplv = 1
      end
      editor.load() --on charge la carte actuelle dans l'éditeur
   end
   if key == "kp+" then --on ajoute une nouvelle carte à la liste des levels
      thismaplv = #dungeon.levels + 1 --on positionne le curseur des niveaux sur le dernier index+1
      addTask({undoIndex + 1, "add", thismaplv}) --on ajoute l'action à la liste undo
      editor.load() --on force le chargement du nouveau niveau, qui sera créé automatiquement, puisqu'il n'existe pas encore
   end
   if key == "insert" then --on insert une nouvelle carte après l'index courant
      thismaplv = thismaplv + 1 --on positionne le curseur sur le futur niveau
      table.insert(dungeon.levels, thismaplv, dungeon.dgLevel.newLevel()) --on crée le nouveau niveau, en l'insérant à l'index indiqué
      addTask({undoIndex + 1, "add", thismaplv}) --on ajoute l'action à la liste undo
      editor.load() --on force le chargement du nouveau niveau
   end
   if key == "kp-" then
      if #dungeon.levels > 0 then
         trashcan[thismaplv] = dungeon.levels[thismaplv] --on jette la carte à la poubelle
         table.remove(dungeon.levels, thismaplv) --et on l'enlève des levels
         addTask({undoIndex + 1, "rem", thismaplv}) --on ajoute l'action à la liste undo
         thismaplv = thismaplv - 1 --on se positionne sur le niveau précédent
         if thismaplv < 1 and #dungeon.levels > 0 then
            thismaplv = 1
         elseif #dungeon.levels == 0 then
            thismaplv = 0
            dungeon.levels = {}
         end
         editor.load()
      end
   end
end

function tools.mousepressed(button, istouch)
end

function tools.wheelmoved(wx, wy)
end

return tools
