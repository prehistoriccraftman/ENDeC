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
      if key == "left" then
         thismaplv = thismaplv - 1
         if thismaplv < 1 then
            thismaplv = 1
         end
      elseif key == "right" then
         thismaplv = thismaplv + 1
         if thismaplv > #dungeon.levels then
            thismaplv = #dungeon.levels
         end
      elseif key == "up" then
         thismaplv = #dungeon.levels
      elseif key == "down" then
         thismaplv = 1
      end
      editor.load()
   end
   if key == "kp+" then
      thismaplv = #dungeon.levels + 1
      undo.addTask({"add", thismaplv})
      editor.load()
   end
   if key == "kp-" then
      if #dungeon.levels > 0 then
         table.insert(trashcan, #trashcan + 1, dungeon.levels[thismaplv])
         undo.addTask({"rem", thismaplv, #trashcan})
         table.remove(dungeon.levels, thismaplv)
         thismaplv = thismaplv - 1
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
   if inbound() then
      focus = "tools"
      print(focus)
   end
end

function tools.wheelmoved(wx, wy)
end

function inbound()
   if mx > tools.canvas.x and my > tools.canvas.y and mx < tools.canvas.w and my < tools.canvas.h then
      return true
   end
   return false
end

return tools
