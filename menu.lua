local menu = {}
local name = "menu"
local undopressed = false
local redopressed = false

menu.canvas = canvas.create(name, 0, 0, 0, 1, 1, wWidth, 50, 1, 1, 1, 1, "alpha")

function menu.canvas.update(self, dt) -- override appelé dans --> updateDraw()
   love.graphics.setColor(0.6, 0.6, 0.6, 1)
   love.graphics.rectangle("fill", 0, 0, menu.canvas.w, menu.canvas.h)
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.print(menu.canvas.name, 10, 10)
end

function menu.load()
end

function menu.update(dt)
   menu.canvas:updateDraw(dt)
   if love.keyboard.isDown('rctrl', 'z') and not undopressed then
      undo()
      undopressed = true
   end
   if love.keyboard.isDown('rctrl', 'y') and not redopressed then
      redo()
      redopressed = true
   end
end

function menu.draw(dt)
   menu.canvas:draw()
end

function menu.keypressed(key)
   if key == "f5" then --sauvegarde
      dungeonMaps = {dungeon.infos, dungeon.levels}
      saveFile(json.encode(dungeonMaps), "UserSaves/Save-Test.dmf")
      saveFile(json.encode({undoIndex, getTasksList()}), "UserSaves/Save-Test.bak")
   end
   if key == "f8" then --chargement
      dungeonMaps = json.decode(loadFile("UserSaves/Save-Test.dmf"))
      local undoContent = json.decode(loadFile("UserSaves/Save-Test.bak"))
      undoIndex, tasksList = undoContent[1], undoContent[2]
      dungeon.load()
      thismaplv = 1
      editor.load()
   end
   -- if love.keyreleased("z") then undopressed = false end
   -- if love.keyreleased("y") then redopressed = false end
end

function menu.mousepressed(button, istouch)
end

function menu.wheelmoved(wx, wy)
end

return menu
