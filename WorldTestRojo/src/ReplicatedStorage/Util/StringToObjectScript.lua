local function StringToObjectScript(String, StartingPoint)
    local Object = nil
    local CurrentPoint = StartingPoint
    for Name in String:gmatch("[^%.]+") do
        if CurrentPoint[Name] ~= nil then
            CurrentPoint = CurrentPoint[Name]
        end
    end
    Object = CurrentPoint
    return Object
end

return StringToObjectScript