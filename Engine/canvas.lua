local canvas = {}

local function preload(self)
  self:start()
  self:finish()
end

local function start(self) -- INIT CANVAS
  love.graphics.setCanvas(self.canvas)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.scale(1, 1)
  love.graphics.clear()
  love.graphics.setColor(self.r, self.g, self.b, self.a)
  love.graphics.setBlendMode(self.blendMode)
end

local function finish(self) -- Init End
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.scale(1, 1)
  --
  love.graphics.setCanvas()
end

local function updateDraw(self, dt)
  love.graphics.push()
  --
  self:start()
  self:update(dt)
  self:finish()
  --
  love.graphics.pop()
end

local function draw(self)
  love.graphics.draw(self.canvas, self.x, self.y, self.rotate, self.sx, self.sy)
end

function canvas.create(
  pName,
  pX,
  pY,
  pRotate,
  pScaleX,
  pScaleY,
  pWidth,
  pHeight,
  pRed,
  pGreen,
  pBlue,
  pAlpha,
  pBlendMode)
  -- print(pName, pX, pY, pRotate, pScaleX, pScaleY, pWidth, pHeight, pRed, pGreen, pBlue, pAlpha, pBlendMode)
  local new = {
    preload = preload,
    start = start,
    finish = finish,
    updateDraw = updateDraw,
    update = function(self)
    end,
    draw = draw
  }
  new.name = pName
  new.x = pX
  new.y = pY
  new.rotate = pRotate
  new.w = pWidth
  new.h = pHeight
  new.r = pRed
  new.g = pGreen
  new.b = pBlue
  new.a = pAlpha
  new.blendMode = pBlendMode
  new.canvas = love.graphics.newCanvas(new.w, new.h)

  new:preload()

  return new
end

function canvas.update(dt)
end

return canvas
