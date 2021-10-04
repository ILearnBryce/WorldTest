local function StringToObjectScript(String, StartingPoint)
    local CurrentPoint = StartingPoint
    for Name in String:gmatch("[^%.]+") do
        if CurrentPoint[Name] ~= nil then
            CurrentPoint = CurrentPoint[Name]
        end
    end
    return CurrentPoint
end

return StringToObjectScript