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

  dungeon.dgWidth = #dgLevel.map[2][1]
  dungeon.dgHeight = #dgLevel.map[2]
  dungeon.w = dungeon.dgWidth * dungeon.tailleCase
  dungeon.h = dungeon.dgHeight * dungeon.tailleCase
end

function dgLevel.newLevel(pname, pstyle, pintro, lv, dw, dh)
    if pname == null then
        name = "nom du niveau " .. lv
    end
    if pstyle == null then
        style = "default style"
    end
    if pintro == null then
        intro = "Blabla d'intro du niveau " .. lv
    end
    if dw == null or dh == null then
        dw, dh = 35, 35
    end

    dgLevel.infos = {name, style, intro, {}, {}}

    for l = 1, dh do
        dgLevel.map[l] = {}
        for c = 1, dw do
            local casetype = math.random(90, 93)
            dgLevel.map[l][c] = casetype
        end
    end
    return {dgLevel.infos, dgLevel.map}
end

return dgLevel
