local tools = {}
local name = "tools"

function tools.load()
    tools.canvas = canvas.create(name, wWidth / 2, 54, 0, 1, 1, wWidth / 2, wHeight - 50, .5, .5, .5, 1, "alpha")
    tools.canvas.update = function(self, dt) -- override appelé dans --> updateDraw()
        lg.setColor(0.5, 0.5, 0.5, 1)
        lg.rectangle("fill", tools.canvas.x, tools.canvas.y, tools.canvas.w, tools.canvas.h)
        lg.setColor(0, 0, 0, 1)
        lg.rectangle("line", tools.canvas.x, tools.canvas.y, tools.canvas.w, tools.canvas.h)
        lg.print(tools.canvas.name, 10, 10)
    end
end

function tools.update(dt)
    tools.canvas.x = wWidth / 2
    tools.canvas.y = 50
    tools.canvas.w = wWidth / 2
    tools.canvas.h = wHeight - 50

    tools.canvas:updateDraw(dt)
end

function tools.draw(dt)
    tools.canvas:draw()
end

function tools.keypressed(key)
end

function tools.mousepressed(mx, my, button, istouch)
end

function tools.wheelmoved(wx, wy)
end

return tools
