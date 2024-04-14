local editor = {}
local donjon = require("Engine.donjon")
local name = "editor"
local editScale = 1

editor.canvas = canvas.create(name, 3, 53, 0, 1, 1, (wWidth / 2) - 7, wHeight - 57, 1, 1, 1, 1, "alpha")

function editor.canvas.update(self, dt)
  -- wZoom:update()

  --Draw inside
  love.graphics.scale(editScale, editScale)
  donjon.draw(dt, "2D", 5, 5)
  love.graphics.scale(1, 1)
end

function editor.load(lv)
  if lv ~= 0 then
    donjon.load(2)
  end
end

function editor.update(dt)
  editor.canvas:updateDraw(dt)
end

function editor.draw()
  editor.canvas:draw()
end

function editor.keypressed(key)
end

function editor.mousepressed(button, istouch)
  if inbound() then
    focus = "editor"
    print(focus)
    if button == 3 then
      editScale = 1
    end
  end
end

function editor.wheelmoved(wx, wy)
  if inbound() then
    -- love.graphics.translate(-mx,-my)
    if wy > 0 then
      editScale = editScale * 1.1
      if editScale > 5 then
        editScale = 5
      end
    elseif wy < 0 then
      editScale = editScale * 0.9
      if editScale < 0.5 then
        editScale = 0.5
      end
    end
  end
end

function inbound()
  if mx > editor.canvas.x and my > editor.canvas.y and mx < editor.canvas.w and my < editor.canvas.h then
    return true
  end
  return false
end

return editor
