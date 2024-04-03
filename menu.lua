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
end

function menu.mousepressed(mx, my, button, istouch)
end

function menu.wheelmoved(wx, wy)
end

return menu
