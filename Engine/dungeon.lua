local dungeon = {}

dungeon.dgLevel = require("Engine.dgLevel")

dungeon.infos = {
   "Quel nom pour ce donjon ?",
   "Quelle est le but de la quête ?",
   "Décrivez le donjon, ses dangers et ses secrets"
}
dungeon.levels = {}

dungeon.lvWidth = 0
dungeon.lvHeight = 0
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

dungeonMaps = {dungeon.infos, dungeon.levels}

function dungeon.case(lv, ligne, colonne)
   return dungeon.dgLevel.map[ligne][colonne]
end

function dungeon.changeCase(lv, ligne, colonne, type)
   dungeon.dgLevel.map[ligne][colonne] = type
end

function dungeon.load()
   if #dungeonMaps > 0 then
      dungeon.infos = dungeonMaps[1]
      dungeon.levels = dungeonMaps[2]
   end
   dungeon.loadLevel(1)
end

function dungeon.loadLevel(lv)
   if not dungeon.levels[lv] and lv ~= 0 then
      dungeon.levels[lv] = dungeon.dgLevel.newLevel(nil, nil, nil, lv)
   end

   dungeon.dgLevel.load(lv)

   dungeon.lvWidth = #dungeon.dgLevel.map[1]
   dungeon.lvHeight = #dungeon.dgLevel.map
   -- dungeon.w = dungeon.lvWidth * dungeon.tailleCase
   -- dungeon.h = dungeon.lvHeight * dungeon.tailleCase
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
