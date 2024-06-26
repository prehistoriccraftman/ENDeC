local donjon = {}

--marge d'affichage
donjon.viewX = 0
donjon.viewY = 0
--taille fenêtre d'affichage
donjon.viewWidth = 200
donjon.viewHeight = 200

local sideWidth1 = 20
local sideWidth2 = 40
local sideWidth3 = 20
local backEndWidth = 40
local c1g = sideWidth1
local c1d = donjon.viewWidth - sideWidth1
local c2g = sideWidth1 + sideWidth2
local c2d = donjon.viewWidth - (sideWidth1 + sideWidth2)
local c3g = sideWidth1 + sideWidth2 + sideWidth3
local c3d = donjon.viewWidth - (sideWidth1 + sideWidth2 + sideWidth3)
local l1h = sideWidth1
local l1b = donjon.viewHeight - sideWidth1
local l2h = sideWidth1 + sideWidth2
local l2b = donjon.viewHeight - (sideWidth1 + sideWidth2)
local l13h = l2h + (sideWidth3 / 3)
local l13b = l2b - (sideWidth3 / 3)
local l3h = sideWidth1 + sideWidth2 + sideWidth3
local l3b = donjon.viewHeight - (sideWidth1 + sideWidth2 + sideWidth3)
local b3g = backEndWidth
local b3d = donjon.viewWidth - (backEndWidth)
local case1Width = donjon.viewWidth
local case2Width = donjon.viewWidth - (sideWidth2 * 2)
local case3Width = sideWidth1 + sideWidth2

donjon.largeur = 0
donjon.hauteur = 0
donjon.tailleCase = 10

donjon.NORD = 1
donjon.EST = 2
donjon.SUD = 3
donjon.OUEST = 4

local cdv = {}
local map = {}
local maps = {}

local blockTable = {} --recense les cases non traversables
for i = 1, 10 do
  blockTable[i] = i + 9 --murs (10-11)
end
for i = 11, 20 do
  blockTable[i] = i + 9 --murs escamotables (20-29 ; disparaissent après escamotage = 90->99)
end
for i = 21, 30 do
  blockTable[i] = i + 19 --portes (40-49)
end

maps[1] = {
  {11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12},
  {12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10},
  {10, 11, 90, 91, 92, 12, 10, 11, 99, 99, 99, 99, 99, 99, 99, 10, 99, 99, 99, 11, 99, 99, 99, 99, 10, 11},
  {11, 12, 99, 99, 99, 40, 99, 12, 99, 11, 12, 10, 11, 12, 99, 40, 99, 99, 99, 12, 50, 11, 12, 40, 11, 12},
  {12, 10, 99, 99, 99, 10, 99, 10, 99, 99, 99, 99, 99, 10, 99, 10, 99, 99, 99, 10, 10, 10, 10, 99, 12, 10},
  {10, 11, 12, 10, 11, 12, 99, 11, 12, 10, 11, 12, 99, 11, 99, 10, 11, 12, 10, 11, 12, 99, 99, 99, 10, 11},
  {11, 12, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 12, 99, 99, 99, 99, 99, 99, 10, 99, 12, 10, 11, 12},
  {12, 10, 99, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 99, 12, 10, 11, 12, 99, 11, 99, 40, 99, 12, 10},
  {10, 11, 99, 10, 99, 99, 99, 99, 99, 10, 11, 12, 10, 11, 99, 10, 99, 99, 99, 99, 12, 99, 11, 12, 10, 11},
  {11, 12, 99, 11, 99, 99, 99, 99, 99, 11, 12, 10, 11, 12, 99, 11, 12, 10, 11, 99, 10, 99, 99, 30, 11, 12},
  {12, 10, 99, 12, 99, 99, 99, 99, 99, 12, 99, 99, 99, 99, 99, 99, 99, 99, 12, 99, 11, 12, 10, 99, 12, 10},
  {10, 11, 99, 10, 99, 99, 99, 99, 99, 10, 99, 12, 99, 11, 99, 10, 99, 99, 10, 99, 99, 99, 99, 99, 10, 11},
  {11, 12, 99, 11, 12, 40, 11, 12, 10, 11, 99, 99, 99, 99, 99, 11, 99, 99, 11, 12, 10, 11, 12, 10, 11, 12},
  {12, 10, 99, 99, 99, 99, 99, 20, 99, 12, 99, 11, 99, 10, 99, 12, 99, 99, 12, 10, 99, 99, 99, 99, 12, 10},
  {10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 99, 99, 99, 99, 99, 10, 11, 40, 10, 11, 40, 10, 11, 99, 10, 11},
  {11, 12, 99, 99, 99, 99, 99, 99, 99, 40, 99, 10, 99, 12, 99, 11, 99, 99, 99, 99, 99, 99, 12, 99, 11, 12},
  {12, 10, 99, 12, 10, 11, 12, 10, 11, 12, 99, 99, 99, 99, 99, 12, 99, 99, 99, 01, 99, 99, 10, 99, 12, 10},
  {10, 11, 99, 10, 99, 99, 99, 99, 99, 10, 99, 12, 20, 11, 99, 10, 99, 99, 99, 99, 99, 99, 11, 99, 10, 11},
  {11, 12, 99, 11, 99, 99, 99, 99, 99, 11, 99, 10, 99, 12, 99, 11, 99, 99, 99, 99, 99, 99, 12, 99, 11, 12},
  {12, 10, 99, 12, 40, 11, 12, 10, 11, 12, 99, 11, 12, 10, 99, 12, 10, 11, 40, 10, 11, 12, 10, 99, 12, 10},
  {10, 11, 99, 10, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 11, 12, 10, 11, 99, 10, 11},
  {11, 12, 40, 11, 12, 10, 11, 12, 10, 11, 12, 10, 99, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 40, 11, 12},
  {12, 10, 99, 99, 99, 99, 99, 99, 99, 99, 99, 11, 99, 10, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 12, 10},
  {10, 11, 12, 10, 11, 12, 99, 11, 99, 10, 99, 12, 99, 10, 99, 10, 99, 12, 99, 11, 12, 10, 11, 12, 10, 11},
  {11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 70, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12},
  {12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10},
  {13, 24, 1}, --départ depuis étage sup. (#map - 1)
  {2, 20, 2} --départ depuis étage inf. (#map)
}

function donjon.case(colonne, ligne)
  return map[ligne][colonne]
end

function donjon.changeCase(ligne, colonne, type)
  map[ligne][colonne] = type
end

function donjon.load(lv, dw, dh)
  if not maps[lv] then
    newMap(lv, dw, dh)
  end
  map = maps[lv]
  donjon.largeur = #map[1]
  donjon.hauteur = #map - 2
  --
  donjon.w = donjon.largeur * donjon.tailleCase
  donjon.h = donjon.hauteur * donjon.tailleCase
end

function donjon.draw2D(px, py)
  if px then
    donjon.viewX = px
  end
  if py then
    donjon.viewY = py
  end

  --
  for ligne = 1, donjon.hauteur do
    for colonne = 1, donjon.largeur do
      local case = map[ligne][colonne]
      local x = (colonne - 1) * donjon.tailleCase
      local y = (ligne - 1) * donjon.tailleCase
      if case >= 90 and case <= 99 then
        love.graphics.setColor(0.2, 0.1, 0.1)
      elseif case >= 10 and case <= 19 then
        love.graphics.setColor(0.5, 0, 0)
      elseif case >= 20 and case <= 29 then
        love.graphics.setColor(0.7, 0.2, 0)
      elseif case >= 30 and case <= 39 then
        love.graphics.setColor(0.5, 0.3, 0.3)
      elseif case >= 40 and case <= 49 then
        love.graphics.setColor(0.3, 0.3, 1)
      elseif case >= 50 and case <= 59 then
        love.graphics.setColor(0, 0.7, 0)
      elseif case >= 60 and case <= 69 then
        love.graphics.setColor(0, 1, 1)
      elseif case >= 70 and case <= 79 then
        love.graphics.setColor(1, 1, 0)
      end
      love.graphics.rectangle("fill", x + px, y + py, donjon.tailleCase, donjon.tailleCase)
      love.graphics.setColor(0, 0, 0)
      love.graphics.setLineWidth(.2)
      love.graphics.rectangle("line", x + px, y + py, donjon.tailleCase, donjon.tailleCase)
      love.graphics.setLineWidth(1)
    end
  end
end

function drawTexture(vertices, ligne, colonne, case)
  if case >= 10 and case < 90 then
    if case >= 10 and case <= 19 then
      love.graphics.setColor(0.5, 0.4, 0.4)
      drawPolygon(vertices)
    elseif case >= 20 and case <= 29 then
      love.graphics.setColor(0.7, 0.2, 0)
      drawPolygon(vertices)
    elseif case >= 30 and case <= 39 then
      love.graphics.setColor(0.5, 0.3, 0.3)
      drawPolygon(vertices)
    elseif case >= 40 and case <= 49 then
      love.graphics.setColor(0.3, 0.3, 1)
      drawPolygon(vertices)
    elseif case >= 50 and case <= 59 then
      love.graphics.setColor(0, 0.7, 0)
      drawPolygon(vertices)
    elseif case >= 60 and case <= 69 then
      love.graphics.setColor(0, 1, 1)
      drawPolygon(vertices)
    elseif case >= 70 and case <= 79 then
      love.graphics.setColor(1, 1, 0)
      drawPolygon(vertices)
    end
    drawShadow(ligne, colonne, vertices)
  end
end

function drawShadow(ligne, colonne, vertices)
  --assombrissement du bloc en fonction de l'éloignement de la case au joueur
  local depth = distance(ligne, colonne) --calcul de l'éloignement
  love.graphics.setColor(0, 0, 0, depth / 10) --définition d'un filtre noir, dont la transparence diminue avec l'éloignement
  love.graphics.polygon("fill", vertices) --dessin du polygone d'assombrissement
end

function drawCeilFloor(vertices, ligne, colonne, case)
  if case >= 90 or case < 10 then
    love.graphics.setColor(0.3, 0.1, 0.0)
    love.graphics.polygon("fill", vertices)
  end
end

function drawTraps(ligne, colonne, case)
  if case == 01 then
    local y = 0
    local x = donjon.viewWidth / 2
    local radiusx, radiusy = 0
    if ligne == 1 then
      y = donjon.viewHeight + sideWidth1
      radiusy = ((sideWidth2 + sideWidth1) / 2) * 0.7
      radiusx = (case1Width / 2) * 0.7
      if colonne == 1 then
        x = x - (case1Width * 2)
      elseif colonne == 2 then
        x = x - case1Width
      elseif colonne == 4 then
        x = x + case1Width
      elseif colonne == 5 then
        x = x + (case1Width * 2)
      end
    elseif ligne == 2 then
      y = l2b + ((l1b - l2b) / 2)
      radiusy = (sideWidth2 / 2) * 0.8
      radiusx = case2Width / 2 * 0.8
      if colonne == 1 then
        x = x - (case2Width * 2)
      elseif colonne == 2 then
        x = x - case2Width
      elseif colonne == 4 then
        x = x + case2Width
      elseif colonne == 5 then
        x = x + (case2Width * 2)
      end
    elseif ligne == 3 then
      y = l3b + ((l2b - l3b) / 2)
      radiusy = (sideWidth1 / 2) * 0.8
      radiusx = case3Width / 2 * 0.8
      if colonne == 1 then
        x = x - (case3Width * 2)
      elseif colonne == 2 then
        x = x - case3Width
      elseif colonne == 4 then
        x = x + case3Width
      elseif colonne == 5 then
        x = x + (case3Width * 2)
      end
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.ellipse("fill", x, y, radiusx, radiusy)
    print(
      "trap drawn at " ..
        x .. "-" .. y .. " on case " .. colonne .. "-" .. ligne .. " radx=" .. radiusx .. ", rady=" .. radiusy
    )
  end
end

function drawPolygon(vertices)
  love.graphics.polygon("fill", vertices)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setLineWidth(.5)
  love.graphics.polygon("line", vertices)
end

function distance(y, x)
  local depth = (y - 1) * 2.75
  if x == 5 or x == 1 then
    depth = depth + 0.5
  elseif x == 4 or x == 2 then
    depth = depth + 0.25
  end
  return depth
end

function donjon.draw3D()
  --dessin du sol
  drawCeilFloor({0, l3b, b3g, l3b, 0, l13b}, 3, 1, cdv[3][1])
  drawShadow(3, 1, {0, l3b, b3g, l3b, 0, l13b})
  drawCeilFloor({b3g, l3b, c3g, l3b, c2g, l2b, 0, l2b, 0, l13b}, 3, 2, cdv[3][2])
  drawShadow(3, 2, {b3g, l3b, c3g, l3b, c2g, l2b, 0, l2b, 0, l13b})
  drawCeilFloor({c3g, l3b, c3d, l3b, c2d, l2b, c2g, l2b}, 3, 3, cdv[3][3])
  drawShadow(3, 3, {c3g, l3b, c3d, l3b, c2d, l2b, c2g, l2b})
  drawCeilFloor({c3d, l3b, b3d, l3b, donjon.viewWidth, l13b, donjon.viewWidth, l2b, c2d, l2b}, 3, 4, cdv[3][4])
  drawShadow(3, 4, {c3d, l3b, b3d, l3b, donjon.viewWidth, l13b, donjon.viewWidth, l2b, c2d, l2b})
  drawCeilFloor({b3d, l3b, donjon.viewWidth, l3b, donjon.viewWidth, l13b}, 3, 5, cdv[3][5])
  drawShadow(3, 5, {b3d, l3b, donjon.viewWidth, l3b, donjon.viewWidth, l13b})
  drawCeilFloor({0, l2b, donjon.viewWidth, l2b, donjon.viewWidth, l1b, 0, l1b}, 2, 2, cdv[2][2])
  drawShadow(2, 2, {0, l2b, donjon.viewWidth, l2b, donjon.viewWidth, l1b, 0, l1b})
  drawCeilFloor({0, l2b, donjon.viewWidth, l2b, donjon.viewWidth, l1b, 0, l1b}, 2, 3, cdv[2][3])
  drawShadow(2, 3, {0, l2b, donjon.viewWidth, l2b, donjon.viewWidth, l1b, 0, l1b})
  drawCeilFloor({0, l2b, donjon.viewWidth, l2b, donjon.viewWidth, l1b, 0, l1b}, 2, 4, cdv[2][4])
  drawShadow(2, 4, {0, l2b, donjon.viewWidth, l2b, donjon.viewWidth, l1b, 0, l1b})
  drawCeilFloor(
    {0, l1b, donjon.viewWidth, l1b, donjon.viewWidth, donjon.viewHeight, 0, donjon.viewHeight},
    1,
    2,
    cdv[1][2]
  )
  drawShadow(1, 2, {0, l1b, donjon.viewWidth, l1b, donjon.viewWidth, donjon.viewHeight, 0, donjon.viewHeight})
  drawCeilFloor(
    {0, l1b, donjon.viewWidth, l1b, donjon.viewWidth, donjon.viewHeight, 0, donjon.viewHeight},
    1,
    3,
    cdv[1][3]
  )
  drawShadow(1, 3, {0, l1b, donjon.viewWidth, l1b, donjon.viewWidth, donjon.viewHeight, 0, donjon.viewHeight})
  drawCeilFloor(
    {0, l1b, donjon.viewWidth, l1b, donjon.viewWidth, donjon.viewHeight, 0, donjon.viewHeight},
    1,
    4,
    cdv[1][4]
  )
  drawShadow(1, 4, {0, l1b, donjon.viewWidth, l1b, donjon.viewWidth, donjon.viewHeight, 0, donjon.viewHeight})

  --dessin du plafond
  drawCeilFloor({0, l3h, donjon.viewWidth, l3h, donjon.viewWidth, l2h, 0, l2h}, 4, 1, 99)
  drawShadow(4, 1, {0, l3h, donjon.viewWidth, l3h, donjon.viewWidth, l2h, 0, l2h})
  drawCeilFloor({0, l2h, donjon.viewWidth, l2h, donjon.viewWidth, l1h, 0, l1h}, 3, 1, 99)
  drawShadow(3, 1, {0, l2h, donjon.viewWidth, l2h, donjon.viewWidth, l1h, 0, l1h})
  drawCeilFloor({0, l1h, donjon.viewWidth, l1h, donjon.viewWidth, 0, 0, 0}, 2, 1, 99)
  drawShadow(2, 1, {0, l1h, donjon.viewWidth, l1h, donjon.viewWidth, 0, 0, 0})

  --ligne 4. On n'y dessine que la face visible au fond du champ de vision
  drawTexture({0, l3h, b3g, l3h, b3g, l3b, 0, l3b}, 4, 1, cdv[4][1])
  drawTexture({b3g, l3h, c3g, l3h, c3g, l3b, b3g, l3b}, 4, 2, cdv[4][2])
  drawTexture({c3g, l3h, c3d, l3h, c3d, l3b, c3g, l3b}, 4, 3, cdv[4][3]) --en face
  drawTexture({c3d, l3h, b3d, l3h, b3d, l3b, c3d, l3b}, 4, 4, cdv[4][4])
  drawTexture({b3d, l3h, donjon.viewWidth, l3h, donjon.viewWidth, l3b, b3d, l3b}, 4, 5, cdv[4][5])

  --ligne 3.
  drawTexture({0, l13h, b3g, l3h, b3g, l3b, 0, l13b}, 3, 1, cdv[3][1]) --gauche+
  drawTexture({b3d, l3h, donjon.viewWidth, l13h, donjon.viewWidth, l13b, b3d, l3b}, 3, 5, cdv[3][5]) --droite+
  drawTexture({c2g, l2h, c3g, l3h, c3g, l3b, c2g, l2b}, 3, 2, cdv[3][2]) --gauche
  drawTexture({0, l2h, c2g, l2h, c2g, l2b, 0, l2b}, 3, 2, cdv[3][2]) --face
  drawTexture({c3d, l3h, c2d, l2h, c2d, l2b, c3d, l3b}, 3, 4, cdv[3][4]) --droite
  drawTexture({c2d, l2h, donjon.viewWidth, l2h, donjon.viewWidth, l2b, c2d, l2b}, 3, 4, cdv[3][4]) --face
  drawTexture({c2g, l2h, c2d, l2h, c2d, l2b, c2g, l2b}, 3, 3, cdv[3][3]) --en face

  --ligne 2.
  drawTexture({c1g, l1h, c2g, l2h, c2g, l2b, c1g, l1b}, 2, 2, cdv[2][2]) --gauche
  drawTexture({0, l1h, c1g, l1h, c1g, l1b, 0, l1b}, 2, 2, cdv[2][2]) --face
  drawTexture({c2d, l2h, c1d, l1h, c1d, l1b, c2d, l2b}, 2, 4, cdv[2][4]) --droite
  drawTexture({c1d, l1h, donjon.viewWidth, l1h, donjon.viewWidth, l1b, c1d, l1b}, 2, 4, cdv[2][4]) --face
  drawTexture({c1g, l1h, c1d, l1h, c1d, l1b, c1g, l1b}, 2, 3, cdv[2][3]) --en face

  --ligne 1.
  drawTexture({0, 0, c1g, l1h, c1g, l1b, 0, donjon.viewHeight}, 1, 2, cdv[1][2]) --gauche
  drawTexture({c1d, l1h, donjon.viewWidth, 0, donjon.viewWidth, donjon.viewHeight, c1d, l1b}, 1, 4, cdv[1][4]) --droite
end

function donjon.draw(dt, mode, px, py, pw, ph)
  if mode == "2D" then
    donjon.draw2D(px, py, pw, ph)
  elseif mode == "3D" then
    donjon.draw3D()
  end
end

function donjon.blocked(case)
  for i = 1, #blockTable do
    if blockTable[i] == case then
      return true
    end
  end
  return false
end

function newMap(lv, dw, dh)
  local newmap = {}
  for l = 1, dh do
    newmap[l] = {}
    for c = 1, dw do
      local casetype = math.random(90, 93)
      newmap[l][c] = casetype
    end
  end
  maps[lv] = newmap
end

return donjon
