local spriteMgmt = {}

function spriteMgmt.getSprite(pimage, width, height)
   local sprite = {}
   sprite.spritSheet = love.graphics.newImage(pimage)
   sprite.quads = {}

   for y = 0, sprite.spritSheet:getHeight() - height, height do
      for x = 0, sprite.spritSheet:getWidth() - width, width do
         table.insert(sprite.quads, love.graphics.newQuad(x, y, width, height, sprite.spritSheet:getDimensions()))
      end
   end

   return sprite
end

return spriteMgmt
