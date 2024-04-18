local dgLevel = {}

dgLevel.infos = {
   name,
   style,
   intro,
   {}, --player position from previous level
   {} --player position from next level
}
dgLevel.map = {}

function dgLevel.load(lv)
   dgLevel.map = dungeon.levels[lv]
end

function dgLevel.newLevel(name, style, intro, lv, dw, dh)
   -- if dw == nil or dh == nil then
   --     dw, dh = 35, 35
   -- end

   local ninfos = {
      name or "nom du niveau " .. lv,
      style or "default style",
      intro or "Blabla d'intro du niveau " .. lv,
      {},
      {}
   }
   local nmap = {}
   local nlevel = {ninfos, nmap}

   for l = 1, dh or 35 do
      nlevel.map[l] = {}
      for c = 1, dw or 35 do
         local casetype = math.random(90, 93)
         nlevel.map[l][c] = casetype
      end
   end
   return {nlevel.ninfos, nlevel.nmap}
end

return dgLevel
