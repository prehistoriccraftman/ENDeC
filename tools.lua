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
      if thismaplv > #maps then
        thismaplv = #maps
      end
    elseif key == "up" then
      thismaplv = #maps
    elseif key == "down" then
      thismaplv = 1
    end
    editor.load()
  end
  if key == "kp+" then
    thismaplv = #maps + 1
    editor.load()
  end
  if key == "kp-" then
    if #maps > 0 then
      table.remove(maps, thismaplv)
      thismaplv = thismaplv - 1
      if thismaplv < 1 and #maps > 0 then
        thismaplv = 1
      elseif #maps == 0 then
        thismaplv = 0
        maps = {}
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
