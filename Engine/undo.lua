local undo = {}

undo.currentIndex = 0
local tasksList = {}

function undo.addTask(task)
   if undo.currentIndex < #tasksList then
      taskList = removeFrom(undo.currentIndex)
   end

   table.insert(tasksList, #tasksList + 1, task)
   undo.currentIndex = undo.currentIndex + 1
end

function undo.getTaskLists()
   return tasksList
end

function undo.undo() --Ctrl + Z
   if tasksList[undo.currentIndex][1] == "edit" then
      dungeon.changeCase(tasksList[undo.currentIndex][2], tasksList[undo.currentIndex][3], type)
   elseif tasksList[undo.currentIndex][1] == "rem" then
      table.insert(dungeon.levels, tasksList[undo.currentIndex][2], trashcan[tasksList[undo.currentIndex][3]])
   elseif tasksList[undo.currentIndex][1] == "add" then
      table.remove(dungeonMaps[2], thismaplv)
   end
   undo.currentIndex = undo.currentIndex - 1
end

function undo.redo() --Ctrl + Y
   undo.currentIndex = undo.currentIndex + 1
   if tasksList[undo.currentIndex][1] == "edit" then
      dungeon.changeCase(tasksList[undo.currentIndex][2], tasksList[undo.currentIndex][3], type)
   elseif tasksList[undo.currentIndex] == "rem" then
      table.remove(dungeon.levels, tasksList[undo.currentIndex][2], trashcan[tasksList[undo.currentIndex][3]])
      table.insert(trashcan, #trashcan + 1, dungeon.levels[thismaplv])
   elseif tasksList[undo.currentIndex] == "add" then
      table.insert(dungeon.levels, thismaplv, trashcan[tasksList[undo.currentIndex][3]])
   end
end

function removeFrom(index)
   local tab = {}
   for i = 1, pIndex do
      table.insert(tab, pTable[i])
   end
   return tab
end

return undo
