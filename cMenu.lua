local menu = {}
local name = "menu"

function menu.load()
  menu.canvas = canvas.create(name, 0, 0, 0, 1, 1, wWidth, 50, 0.6, 0.6, 0.6, 1, "alpha")
  menu.canvas.update = function(self, dt) -- override appelé dans --> updateDraw()
    lg.setColor(0.6, 0.6, 0.6, 1)
    lg.rectangle("fill", menu.canvas.x, menu.canvas.y, menu.canvas.w, menu.canvas.h)
    lg.setColor(1,1,1, 1)
    lg.print(menu.canvas.name, 10, 10)
  end
end

function menu.update(dt)
  menu.canvas.x = 0
  menu.canvas.y = 0
  menu.canvas.w = wWidth
  menu.canvas.h = 50

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
