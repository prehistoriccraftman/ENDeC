local editor = {}
local donjon = require("Engine.donjon")
local name = "editor"
local editScale = 1

editor.canvas = canvas.create(name, 0, 53, 0, 1, 1, (wWidth / 2) - 6, wHeight - 56, 1, 1, 1, 1, "alpha")

function editor.canvas.update(self, dt)

  --Draw inside
  love.graphics.scale(editScale, editScale)
  donjon.draw(dt, "2D", 0, 0)
  love.graphics.scale(1, 1)


  -- title
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.print("editor", 13, 63)

end

function editor.load(lv)

  if lv ~= 0 then
    donjon.load(1)
  end

end

function editor.update(dt)
  editor.canvas:updateDraw(dt)
end

function editor.draw()
  editor.canvas:draw()

  -- border
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle("line", editor.canvas.x, editor.canvas.y, editor.canvas.w, editor.canvas.h)
  love.graphics.setColor(1, 1, 1, 1)
end

function editor.keypressed(key)
end

function editor.mousepressed(mx, my, button, istouch)
end

function editor.wheelmoved(wx, wy)
  local mx = love.mouse.getX()
  local my = love.mouse.getY()
  local wdir = ""
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

return editor
