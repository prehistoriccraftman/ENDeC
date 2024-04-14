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
