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
maps = {}
thismaplv = 0

canvas = require("Engine.canvas")
json = require("Engine.json")

menu = require("menu") --barre de menu
tools = require("tools") --zone outils
editor = require("editor") --cadre d'édition de la carte
love.filesystem.setIdentity(love.filesystem.getIdentity(), true)

function love.load()
  menu.load()
  tools.load()
  editor.load()
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
