local editor = {}
local name = "editor"

function editor.load()
    editor.canvas = canvas.create(name, 3, 53, 0, 1, 1, (wWidth / 2) - 6, wHeight - 56, 1, 1, 1, 1, "alpha")
    editor.canvas.update = function(self, dt) -- override appelé dans --> updateDraw()
        lg.setColor(0.7, 0, 1, 1)
        lg.rectangle("fill", editor.canvas.x, editor.canvas.y, editor.canvas.w, editor.canvas.h)
        lg.setColor(0, 0, 0, 1)
        lg.rectangle("line", editor.canvas.x, editor.canvas.y, editor.canvas.w, editor.canvas.h)
        lg.print(editor.canvas.name, 10, 10)
    end
end

function editor.update(dt)
--    editor.canvas.x = 3
--    editor.canvas.y = 50
--    editor.canvas.w = (wWidth / 2) - 6
--    editor.canvas.h = wHeight - 56

    editor.canvas:updateDraw(dt)
end

function editor.draw(dt)
    editor.canvas:draw()
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
        scale = scale + 0.5
        if scale > 5 then
            scale = 5
        end
    elseif wy < 0 then
        scale = scale - 0.5
        if scale < 0.5 then
            scale = 0.5
        end
    end
end

return editor
