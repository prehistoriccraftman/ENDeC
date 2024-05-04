local menu = {}
local name = "menu"
local undopressed = false
local redopressed = false

local loadSprite
local saveSprite
local newDngSprite
local newMapSprite
local delMapSprite
local undoSprite
local redoSprite

local BtnLoad
local BtnSave
local BtnNewDng
local BtnNewMap
local BtndelMap
local BtnUndo
local BtnRedo

menu.canvas = canvas.create(name, 0, 0, 0, 1, 1, wWidth, 50, 1, 1, 1, 1, "alpha")

function menu.canvas.update(self, dt) -- override appelé dans --> updateDraw()
   love.graphics.setColor(0.6, 0.6, 0.6, 1)
   love.graphics.rectangle("fill", 0, 0, menu.canvas.w, menu.canvas.h)
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.print(menu.canvas.name, 10, 10)
end

function menu.load()
   loadSprite = spriteMgmt.getSprite("Images/BtnLoad.png", 20, 11)
   saveSprite = spriteMgmt.getSprite("Images/BtnSave.png", 20, 11)
   newDngSprite = spriteMgmt.getSprite("Images/BtnNewDng.png", 20, 15)
   newMapSprite = spriteMgmt.getSprite("Images/BtnNewLv.png", 20, 15)
   delMapSprite = spriteMgmt.getSprite("Images/BtnDelLv.png", 20, 15)
   undoSprite = spriteMgmt.getSprite("Images/BtnUndo.png", 20, 11)
   redoSprite = spriteMgmt.getSprite("Images/BtnRedo.png", 20, 11)
   BtnLoad = uiButton.creaBtn(19, 5, loadSprite.quads[3], loadSprite.quads[4], loadSprite.quads[1], loadSprite.quads[2])
   BtnSave =
      uiButton.creaBtn(19, 30, saveSprite.quads[3], saveSprite.quads[4], saveSprite.quads[1], saveSprite.quads[2])
   BtnNewDng = uiButton.creaBtn(17, 75, newDngSprite.quads[3], newDngSprite.quads[4])
   BtnNewMap = uiButton.creaBtn(17, 100, newMapSprite.quads[3], newMapSprite.quads[4])
   BtndelMap = uiButton.creaBtn(17, 125, delMapSprite.quads[3], delMapSprite.quads[4])
   BtnUndo =
      uiButton.creaBtn(19, 165, undoSprite.quads[3], undoSprite.quads[4], undoSprite.quads[1], undoSprite.quads[2])
   BtnRedo =
      uiButton.creaBtn(19, 90, redoSprite.quads[3], redoSprite.quads[4], redoSprite.quads[1], redoSprite.quads[2])
end

function menu.update(dt)
   menu.canvas:updateDraw(dt)
   if love.keyboard.isDown("rctrl", "z") and not undopressed then
      undo()
      undopressed = true
   end
   if love.keyboard.isDown("rctrl", "y") and not redopressed then
      redo()
      redopressed = true
   end
   
   BtnLoad:update(dt)
   BtnSave:update(dt)
   BtnNewDng:update(dt)
   BtnNewMap:update(dt)
   BtndelMap:update(dt)
   BtnUndo:update(dt)
   BtnRedo:update(dt)
end

function menu.draw(dt)
   menu.canvas:draw()
   BtnLoad:draw()
   BtnSave:draw()
   BtnNewDng:draw()
   BtnNewMap:draw()
   BtndelMap:draw()
   BtnUndo:draw()
   BtnRedo:draw()
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
