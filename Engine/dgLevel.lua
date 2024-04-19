local dgLevel = {}

dgLevel.infos = {
   name,
   style,
   intro,
   {}, --player position from previous level
   {} --player position from next level
}
dgLevel.map = {}
dgLevel.content = {}

function dgLevel.load(lv)
   dgLevel.infos = dungeon.levels[lv][1]
   dgLevel.map = dungeon.levels[lv][2]
   dgLevel.content = dungeon.levels[lv][3]
end

function dgLevel.newLevel(name, style, intro, lv, dw, dh, content)
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
   local ncontent = {}
   table.insert(ncontent, 
   {
      "cette troisième table recensera les objets, les mécanismes et les créatures {id, x, y, dir, \"description générée ou manuelle\"}"
   })
   return {ninfos, nmap, ncontent}
end

return dgLevel
