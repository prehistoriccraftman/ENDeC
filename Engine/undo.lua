local undo = {}

undo.currentIndex = 0
local tasksList = {}

function undo.addTask(task)
   if undo.currentIndex < #tasksList then
      taskList = removeAfter(undo.currentIndex)
   end

   table.insert(tasksList, #tasksList + 1, task)
   while #taskList > 1000 do
      table.remove(taskList, 1)
   end
   undo.currentIndex = #tasksList
end

function undo.getTaskLists()
   return tasksList
end

function undo.undo() --Ctrl + Z
   if #taskList > 0 then
      if tasksList[undo.currentIndex][1] == "edit" then --on rétablit ce qui a été modifié
         dungeon.changeCase(tasksList[undo.currentIndex][2], tasksList[undo.currentIndex][3], type)
      elseif tasksList[undo.currentIndex][1] == "rem" then --on remet ce qui a été enlevé
         table.insert(dungeon.levels, tasksList[undo.currentIndex][2], trashcan[tasksList[undo.currentIndex][2]])
         trashcan[tasksList[undo.currentIndex][2]] = nil --on retire la carte restaurée de la poubelle
      elseif tasksList[undo.currentIndex][1] == "add" then --on enlève ce qui a été ajouté         
         trashcan[tasksList[undo.currentIndex][2]] = dungeon.levels[tasksList[undo.currentIndex][2]] --on jette la carte à la poubelle
         table.remove(dungeon.levels, tasksList[undo.currentIndex][2]) --et on l'enlève des levels
      end
      undo.currentIndex = undo.currentIndex - 1 --on recule le curseur d'un pas
      if undo.currentIndex < 0 then
         undo.currentIndex = 0
      end
   end
end

function undo.redo() --Ctrl + Y
   if #taskList > 0 then
      undo.currentIndex = undo.currentIndex + 1 --on avance le curseur d'un pas
      if undo.currentIndex > #taskList then
         undo.currentIndex = #taskList
      end
      if tasksList[undo.currentIndex][1] == "edit" then --on remodifie ce qui avait été rétabli
         dungeon.changeCase(tasksList[undo.currentIndex][2], tasksList[undo.currentIndex][3], type)
      elseif tasksList[undo.currentIndex] == "rem" then --on on retire ce qui avait été restauré
         trashcan[thismaplv] = dungeon.levels[thismaplv] --on rejette la carte à la poubelle
         table.remove(dungeon.levels, tasksList[undo.currentIndex][2], trashcan[tasksList[undo.currentIndex][3]]) --et on l'enlève des levels
      elseif tasksList[undo.currentIndex] == "add" then --on remet ce qui avait été enlevé
         table.insert(dungeon.levels, thismaplv, trashcan[tasksList[undo.currentIndex][3]])
      end
   end
end

function removeAfter(ptable, pindex)
   local tab = {}
   for i = 1, pindex do
      table.insert(tab, pTable[i])
   end
   ptable = tab
end

return undo
