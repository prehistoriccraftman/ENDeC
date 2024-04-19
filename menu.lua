local menu = {}
local name = "menu"

-- ICI
menu.canvas = canvas.create(name, 0, 0, 0, 1, 1, wWidth, 50, 1, 1, 1, 1, "alpha")

-- et LA :
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
end

function menu.draw(dt)
   menu.canvas:draw()
end

function menu.keypressed(key)
   if key == "f5" then --sauvegarde
      dungeonMaps = {dungeon.infos, dungeon.levels}
      saveFile(json.encode(dungeonMaps), "E:/GitHub/ENDeC/UserSaves/Save-Test.dmf")
      saveFile(json.encode({undoIndex, getTasksList()}), "E:/GitHub/ENDeC/UserSaves/Save-Test.bak")
   elseif key == "f8" then --chargement
      dungeonMaps = json.decode(loadFile("E:/GitHub/ENDeC/UserSaves/Save-Test.dmf"))
      local undoContent = json.decode(loadFile("E:/GitHub/ENDeC/UserSaves/Save-Test.bak"))
      undoIndex, tasksList = undoContent[1], undoContent[2]
      dungeon.load(dungeonMaps)
      thismaplv = 1
      editor.load()
   end
end

function menu.mousepressed(button, istouch)
   if inbound() then
      focus = "menu"
      print(focus)
   end
end

function menu.wheelmoved(wx, wy)
end

function inbound()
   if mx > menu.canvas.x and my > menu.canvas.y and mx < menu.canvas.w and my < menu.canvas.h then
      return true
   end
   return false
end

function undo()
   if undo[#undo][1] == "edit" then
      dungeon.changeCase(undo[#undo][2], undo[#undo][3], type)
   elseif undo[#undo][1] == "rem" then
      table.insert(dungeon.levels, undo[#undo][2], trashcan[undo[#undo][3]])
   elseif undo[#undo][1] == "add" then
      table.remove(dungeonMaps[2], thismaplv)
   end
   undoIndex = undoIndex - 1
end

function saveFile(str, filename)
   local success
   local errormessage

   thisfile = io.open(filename, "w")
   success, errormessage = thisfile:write(str)
   thisfile:close()

   print(succes, errormessage)
end

function loadFile(filename)
   local content

   thisfile = io.open(filename, "r")
   content = thisfile:read("*all")
   thisfile:close()

   return content
end

return menu
