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
   dgLevel.infos = dungeon.levels[lv][1]
   dgLevel.map = dungeon.levels[lv][2]
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
   -- local nlevel = {ninfos, nmap}
   for l = 1, dh or 35 do
      nmap[l] = {}
      for c = 1, dw or 35 do
         local casetype = math.random(90, 93)
         nmap[l][c] = casetype
      end
   end
   return {ninfos, nmap}
end

return dgLevel
