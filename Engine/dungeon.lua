local dungeon = {}

dungeon.dgLevel = require("Engine.dgLevel")

dungeon.infos = {
   "Quel nom pour ce donjon ?",
   "Quelle est le but de la quête ?",
   "Décrivez le donjon, ses dangers et ses secrets"
}
dungeon.levels = {}

dungeon.dgWidth = 0
dungeon.dgHeight = 0
dungeon.tailleCase = 10

dungeon.NORD = 1
dungeon.EST = 2
dungeon.SUD = 3
dungeon.OUEST = 4

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

dungeon.levels[1] = {
   {
      "nom du niveau 1",
      "default style",
      "blabla d'intro du niveau 1",
      {13, 24, 1}, --départ depuis étage sup.
      {2, 20, 2}, --départ depuis étage inf.
      {1,3}, --fourchette de niveaux des créatures
      {1,1}, --fourchette de niveaux des trésors
      {0,2,10}, --pourcentage de chance qu'un objet "non tagué" trouvé soit légendaire, rare, recherché. Au delà c'est un objet commun
   },
   {
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
      {12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10, 11, 12, 10}
   },
   {
      "cette troisième table recensera les objets, les mécanismes et les créatures {id, x, y, dir, \"description générée ou manuelle\"}"
   }
}

function dungeon.case(lv, ligne, colonne)
   return dungeon.levels[lv][ligne][colonne]
end

function dungeon.changeCase(lv, ligne, colonne, type)
   dungeon.levels[lv][ligne][colonne] = type
end

--[[ function dungeon.clickBlock(mx, my)
  if mx - dungeon.viewX >= c1g and mx - dungeon.viewX <= c1d and my - dungeon.viewY >= l1h and my - dungeon.viewY <= l1b then
    return true
  end
  return false
end ]]
--[[ function changeCDV(vcolonne, vligne, mapligne, mapcolonne)
  if mapcolonne > 0 and mapligne > 0 and mapcolonne <= dungeon.dgWidth and mapligne <= dungeon.dgHeight then
    cdv[vligne][vcolonne] = map[mapligne][mapcolonne]
  end
end ]]
--[[ function dungeon.calculCDV()
    cdv = {}
    for ligne = 1, 4 do
        cdv[ligne] = {0, 0, 0, 0, 0}
    end

    local x = joueur.coord[1]
    local y = joueur.coord[2]

    if joueur.coord[3] == dungeon.NORD then
        --ligne joueur
        changeCDV(1, 1, y, x - 2) --gauche+2
        changeCDV(2, 1, y, x - 1) --gauche+1
        changeCDV(3, 1, y, x) --centre
        changeCDV(4, 1, y, x + 1) --droite+1
        changeCDV(5, 1, y, x + 2) --droite+2
        --ligne devant
        changeCDV(1, 2, y - 1, x - 2)
        changeCDV(2, 2, y - 1, x - 1)
        changeCDV(3, 2, y - 1, x)
        changeCDV(4, 2, y - 1, x + 1)
        changeCDV(5, 2, y - 1, x + 2)
        --ligne +2
        changeCDV(1, 3, y - 2, x - 2)
        changeCDV(2, 3, y - 2, x - 1)
        changeCDV(3, 3, y - 2, x)
        changeCDV(4, 3, y - 2, x + 1)
        changeCDV(5, 3, y - 2, x + 2)
        --ligne +3 dernière visible
        changeCDV(1, 4, y - 3, x - 2)
        changeCDV(2, 4, y - 3, x - 1)
        changeCDV(3, 4, y - 3, x)
        changeCDV(4, 4, y - 3, x + 1)
        changeCDV(5, 4, y - 3, x + 2)
    end
    if joueur.coord[3] == dungeon.EST then
        --ligne joueur
        changeCDV(1, 1, y - 2, x)
        changeCDV(2, 1, y - 1, x)
        changeCDV(3, 1, y, x)
        changeCDV(4, 1, y + 1, x)
        changeCDV(5, 1, y + 2, x)
        --ligne devant
        changeCDV(1, 2, y - 2, x + 1)
        changeCDV(2, 2, y - 1, x + 1)
        changeCDV(3, 2, y, x + 1)
        changeCDV(4, 2, y + 1, x + 1)
        changeCDV(5, 2, y + 2, x + 1)
        --ligne +2
        changeCDV(1, 3, y - 2, x + 2)
        changeCDV(2, 3, y - 1, x + 2)
        changeCDV(3, 3, y, x + 2)
        changeCDV(4, 3, y + 1, x + 2)
        changeCDV(5, 3, y + 2, x + 2)
        --ligne +3 dernière visible
        changeCDV(1, 4, y - 2, x + 3)
        changeCDV(2, 4, y - 1, x + 3)
        changeCDV(3, 4, y, x + 3)
        changeCDV(4, 4, y + 1, x + 3)
        changeCDV(5, 4, y + 2, x + 3)
    end
    if joueur.coord[3] == dungeon.SUD then
        --ligne joueur
        changeCDV(1, 1, y, x + 2)
        changeCDV(2, 1, y, x + 1)
        changeCDV(3, 1, y, x)
        changeCDV(4, 1, y, x - 1)
        changeCDV(5, 1, y, x - 2)
        --ligne devant
        changeCDV(1, 2, y + 1, x + 2)
        changeCDV(2, 2, y + 1, x + 1)
        changeCDV(3, 2, y + 1, x)
        changeCDV(4, 2, y + 1, x - 1)
        changeCDV(5, 2, y + 1, x - 2)
        --ligne +2
        changeCDV(1, 3, y + 2, x + 2)
        changeCDV(2, 3, y + 2, x + 1)
        changeCDV(3, 3, y + 2, x)
        changeCDV(4, 3, y + 2, x - 1)
        changeCDV(5, 3, y + 2, x - 2)
        --ligne +3 dernière visible
        changeCDV(1, 4, y + 3, x + 2)
        changeCDV(2, 4, y + 3, x + 1)
        changeCDV(3, 4, y + 3, x)
        changeCDV(4, 4, y + 3, x - 1)
        changeCDV(5, 4, y + 3, x - 2)
    end
    if joueur.coord[3] == dungeon.OUEST then
        --ligne joueur
        changeCDV(1, 1, y + 2, x)
        changeCDV(2, 1, y + 1, x)
        changeCDV(3, 1, y, x)
        changeCDV(4, 1, y - 1, x)
        changeCDV(5, 1, y - 2, x)
        --ligne devant
        changeCDV(1, 2, y + 2, x - 1)
        changeCDV(2, 2, y + 1, x - 1)
        changeCDV(3, 2, y, x - 1)
        changeCDV(4, 2, y - 1, x - 1)
        changeCDV(5, 2, y - 2, x - 1)
        --ligne +2
        changeCDV(1, 3, y + 2, x - 2)
        changeCDV(2, 3, y + 1, x - 2)
        changeCDV(3, 3, y, x - 2)
        changeCDV(4, 3, y - 1, x - 2)
        changeCDV(5, 3, y - 2, x - 2)
        --ligne +3 dernière visible
        changeCDV(1, 4, y + 2, x - 3)
        changeCDV(2, 4, y + 1, x - 3)
        changeCDV(3, 4, y, x - 3)
        changeCDV(4, 4, y - 1, x - 3)
        changeCDV(5, 4, y - 2, x - 3)
    end
end ]]
function dungeon.load(dungeonMaps)
   if #dungeonMaps > 0 then
      dungeon.infos = dungeonMaps[1]
      dungeon.levels = dungeonMaps[2]
   end
   dungeon.dgLevel.load(1)
end

function dungeon.loadLevel(lv)
   if not dungeon.levels[lv] and lv ~= 0 then
      dungeon.levels[lv] = dungeon.dgLevel.newLevel(nil, nil, nil, lv)
   end

   dungeon.dgLevel.load(lv)

   dungeon.dgWidth = #dungeon.dgLevel.map[1]
   dungeon.dgHeight = #dungeon.dgLevel.map
   dungeon.w = dungeon.dgWidth * dungeon.tailleCase
   dungeon.h = dungeon.dgHeight * dungeon.tailleCase
end

function dungeon.blocked(case)
   for i = 1, #blockTable do
      if blockTable[i] == case then
         return true
      end
   end
   return false
end

return dungeon
