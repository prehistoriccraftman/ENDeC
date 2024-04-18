local popup = {}

function popup.load()
end

function popup.update(dt)
end

function popup.draw(dt)
end

function popup.keypressed(key)
end

function popup.mousepressed(mx, my, button, istouch)
end

function popup.wheelmoved(wx, wy)
   local mx = love.mouse.getX()
   local my = love.mouse.getY()
   if wy > 0 then
   elseif wy < 0 then
   end
end

return popup
