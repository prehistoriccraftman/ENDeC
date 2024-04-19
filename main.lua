-- Debugger VSCode
if pcall(require, "lldebugger") then
   require("lldebugger").start()
end

-- verbosité du débuggage
io.stdout:setvbuf("no")

-- filtre graphique : lissage des pixels
love.graphics.setDefaultFilter("nearest")

-- environnement vars :
love.window.setTitle("ENDeC : Editeur de niveaux pour DCengine (v 0.2)")
local w, h = love.window.getDesktopDimensions(1)
love.window.setMode(w, h, {resizable = true, vsync = 1, borderless = false, centered = true})
love.window.maximize()
wWidth, wHeight = love.graphics.getDimensions()
focusOn = "none"
mx, my = 0, 0
dungeonMaps = {}
thismaplv = 1
trashcan = {}
trashcanIndex = 0

canvas = require("Engine.canvas")
json = require("Engine.json")
dgDrawing = require("Engine.dgDrawing")
dungeon = require("Engine.dungeon")
-- undo = require("Engine.undo")

menu = require("menu") --barre de menu
tools = require("tools") --zone outils
editor = require("editor") --cadre d'édition de la carte

love.filesystem.setIdentity(love.filesystem.getIdentity(), true)

function love.load()
   trashcanIndex = 0
   thismaplv = 1
   menu.load()
   tools.load()
   editor.load()
   load()
end

function love.update(dt)
   wWidth, wHeight = love.graphics.getDimensions()
   mx = love.mouse.getX()
   my = love.mouse.getY()

   menu.update(dt)
   tools.update(dt)
   editor.update(dt)
end

function love.draw()
   love.graphics.setBackgroundColor(0.7, 0.7, 0.7, 1)
   love.graphics.setColor(0.7, 0, 1, 1)
   love.graphics.rectangle("fill", 3, 53, (wWidth / 2) - 6, wHeight - 56)
   love.graphics.setColor(0, 0, 0, 1)
   love.graphics.rectangle("line", 2, 52, (wWidth / 2) - 5, wHeight - 55)
   love.graphics.setColor(1, 1, 1, 1)

   menu.draw()
   tools.draw()
   editor.draw()
end

function love.keypressed(key)
   editor.keypressed(key)
   menu.keypressed(key)
   tools.keypressed(key)
end

function love.mousepressed(x, y, button, istouch)
   editor.mousepressed(button, istouch)
   menu.mousepressed(button, istouch)
   tools.mousepressed(button, istouch)
end

function love.wheelmoved(wx, wy)
   editor.wheelmoved(wx, wy)
   menu.wheelmoved(wx, wy)
   tools.wheelmoved(wx, wy)
end

undoIndex = 0
tasksList = {}

function addTask(task)
   if undoIndex < #tasksList then
      tasksList = removeAfter(undoIndex)
   end

   table.insert(tasksList, #tasksList + 1, task)
   while #tasksList > 1000 do
      table.remove(tasksList, 1)
   end
   undoIndex = #tasksList
end

function getTasksList()
   return tasksList
end

function undo() --Ctrl + Z
   if #tasksList > 0 then
      if tasksList[undoIndex][1] == "edit" then --on rétablit ce qui a été modifié
         dungeon.changeCase(tasksList[undoIndex][2], tasksList[undoIndex][3], type)
      elseif tasksList[undoIndex][1] == "rem" then --on remet ce qui a été enlevé
         table.insert(dungeon.levels, tasksList[undoIndex][2], trashcan[tasksList[undoIndex][2]])
         trashcan[tasksList[undoIndex][2]] = nil --on retire la carte restaurée de la poubelle
      elseif tasksList[undoIndex][1] == "add" then --on enlève ce qui a été ajouté         
         trashcan[tasksList[undoIndex][2]] = dungeon.levels[tasksList[undoIndex][2]] --on jette la carte à la poubelle
         table.remove(dungeon.levels, tasksList[undoIndex][2]) --et on l'enlève des levels
      end
      undoIndex = undoIndex - 1 --on recule le curseur d'un pas
      if undoIndex < 0 then
         undoIndex = 0
      end
   end
end

function redo() --Ctrl + Y
   if #tasksList > 0 then
      undoIndex = undoIndex + 1 --on avance le curseur d'un pas
      if undoIndex > #tasksList then
         undoIndex = #tasksList
      end
      if tasksList[undoIndex][1] == "edit" then --on remodifie ce qui avait été rétabli
         dungeon.changeCase(tasksList[undoIndex][2], tasksList[undoIndex][3], type)
      elseif tasksList[undoIndex] == "rem" then --on on retire ce qui avait été restauré
         trashcan[thismaplv] = dungeon.levels[thismaplv] --on rejette la carte à la poubelle
         table.remove(dungeon.levels, tasksList[undoIndex][2], trashcan[tasksList[undoIndex][3]]) --et on l'enlève des levels
      elseif tasksList[undoIndex] == "add" then --on remet ce qui avait été enlevé
         table.insert(dungeon.levels, thismaplv, trashcan[tasksList[undoIndex][3]])
      end
   end
end

function load()
end

function removeAfter(ptable, pindex)
   local tab = {}
   for i = 1, pindex do
      table.insert(tab, pTable[i])
   end
   ptable = tab
end