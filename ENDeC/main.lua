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

canvas = require("Engine.canvas")
json = require("Engine.json")

menu = require("menu") --barre de menu
editor = require("editor") --cadre d'édition de la carte
tools = require("tools") --zone outils

function love.load()
  menu.load()
  editor.load()
  tools.load()
end

function love.update(dt)
  wWidth, wHeight = love.graphics.getDimensions()
  --
  menu.update(dt)
  editor.update(dt)
  tools.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(0.7, 0.7, 0.7, 1)
  love.graphics.setColor(0.7, 0, 1, 1)
  love.graphics.rectangle("fill", 3, 53, (wWidth / 2) - 6, wHeight - 56)
  love.graphics.setColor(1, 1, 1, 1)

  menu.draw()
  editor.draw()
  tools.draw()
end

function love.keypressed(key)
  editor.keypressed(key)
end

function love.mousepressed(x, y, button, istouch)
  editor.mousepressed(mx, my, button, istouch)
end

function love.wheelmoved(wx, wy)
  editor.wheelmoved(wx, wy)
end
