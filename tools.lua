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
      if thismaplv > #dungeonMaps[2] then
        thismaplv = #dungeonMaps[2]
      end
    elseif key == "up" then
      thismaplv = #dungeonMaps[2]
    elseif key == "down" then
      thismaplv = 1
    end
    editor.load()
  end
  if key == "kp+" then
    thismaplv = #dungeonMaps[2] + 1
    editor.load()
  end
  if key == "kp-" then
    if #dungeonMaps[2] > 0 then
      table.insert(editor.trash, dungeonMaps[2][thismaplv])
      table.remove(dungeonMaps[2], thismaplv)
      thismaplv = thismaplv - 1
      if thismaplv < 1 and #dungeonMaps[2] > 0 then
        thismaplv = 1
      elseif #dungeonMaps[2] == 0 then
        thismaplv = 0
        dungeonMaps[2] = {}
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
