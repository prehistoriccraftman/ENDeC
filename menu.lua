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
  if key == "f5" then --sauvegarde
    local success, errormessage = json.writeFile(json.encode(dungeonMaps), "E:/GitHub/ENDeC/UserSaves/Save-Test.dmf")
    if success then
      print("file saved")
    else
      print(errormessage)
    end
  elseif key == "f8" then --chargement
    dungeonMaps = json.decode(json.readFile("E:/GitHub/ENDeC/UserSaves/Save-Test.dmf"))
    dungeon.load(dungeonMaps)
    thismaplv = 1
    editor.load()
  end
end

function menu.mousepressed(button, istouch)
  if inbound() then
    focus = "menu"
    print(focus)
  end
end

function menu.wheelmoved(wx, wy)
end

function inbound()
  if mx > menu.canvas.x and my > menu.canvas.y and mx < menu.canvas.w and my < menu.canvas.h then
    return true
  end
  return false
end

return menu
