local DataStoreScript = {}
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Modules = ServerStorage:WaitForChild("Modules")
local ExploitScriptNR = Modules:WaitForChild("ExploitScript")
local DataScript = require(script.DataScript)
local Slots = {"N/A", "A", "B", "C"}
local IsServer = RunService:IsServer()
local IsStudio = RunService:IsStudio()
local ScriptCom = ReplicatedStorage:WaitForChild("ScriptCom")
local ScriptRemote = ScriptCom:WaitForChild("DataStoreScript")
local Util = ReplicatedStorage:WaitForChild("Util")
local StringToObjectScript = require(Util:WaitForChild("StringToObjectScript"))
local StudioOveride = false
DataStoreScript.ClientFunc = {}
DataStoreScript.Data = {}
DataStoreScript.DataLoaded = {}

function DataStoreScript.ClientFunc.DataGet(Variables)
    local Player = Variables[1]
    local Slot = Variables[2]
    local DataKey = Variables[3]
    local Value = nil
    if DataStoreScript.DataLoaded[Player.UserId] == true then
        if Slot == "Current" then
            Slot = DataStoreService.Data[Player.UserId][DataStoreService.Data[Player.UserId]["N/A"].Slot]
        else
            Slot = DataStoreService.Data[Player.UserId][Slot]
        end
        Value = StringToObjectScript(DataKey, Slot)
    else error("ServerStorage.Modules.DataStoreScript - Player Data is not loaded, Script is not functioning correctly?")
    end
    return Value
end

function DataStoreScript.ClientFunc.DataChange(Variables)
    local Player = Variables[1]
    local Slot = Variables[2]
    local DataKey = Variables[3]
    local Value = Variables[4]
    if DataStoreScript.DataLoaded[Player.UserId] == true then
        if Slot == "Current" then
            Slot = DataStoreService.Data[Player.UserId][DataStoreService.Data[Player.UserId]["N/A"].Slot]
        else
            Slot = DataStoreService.Data[Player.UserId][Slot]
        end
        StringToObjectScript(DataKey, Slot) = Value
    else error("ServerStorage.Modules.DataStoreScript - Player Data is not loaded, Script is not functioning correctly?")
    end
end

function DataStoreScript.SortData(Data, DataSaved)
end

function DataStoreScript.GetAsync(DataStore, DataFile, Attempts)
    local Tries = 0
    local Data = nil
    local Success = nil
    local Message = nil
    repeat
        Tries = Tries + 1
        Success, Message = pcall(function()
            Data = DataStore:GetAsync(DataFile)
        end)
        if not Success then
            warn("ServerStorage.Modules.DataStoreScript - " .. Message)
            wait(1)
        end
    until Success or Tries >= Attempts
    return Data, Success
end

function DataStoreScript.SetAsync(DataStore, DataFile, Data, Attempts)
    local Tries = 0
    local Success = nil
    local Message = nil
    repeat
        Tries = Tries + 1
        Success, Message = pcall(function()
            DataStore:SetAsync(DataFile, Data)
        end)
        if not Success then
            warn("ServerStorage.Modules.DataStoreScript - " .. Message)
            wait(1)
        end
    until Success or Tries >= Attempts
    return Success
end

function DataStoreScript.PlayerAdded(Player)
    if not DataStoreScript.DataLoaded[Player.UserId] == true then
        local DataStore = DataStoreService:GetDataStore(Player.UserId)
        DataStoreScript.DataLoaded[Player.UserId] = false
        local PlayerData = {
            ["N/A"] = DataScript["N/A"],
            ["A"] = DataScript.MainSlots,
            ["B"] = DataScript.MainSlots,
            ["C"] = DataScript.MainSlots
        }
        local PlayerSuccess = {
            ["N/A"] = false,
            ["A"] = false,
            ["B"] = false,
            ["C"] = false
        }
        local DataLoaded = true
        for _, Slot in pairs (Slots) do
            local Data, Success = DataStoreScript.GetAsync(DataStore, "Slot" .. Slot, 3)
            PlayerSuccess[Slot] = Success
            if Data ~= nil then
               PlayerData[Slot] = DataStoreScript.SortData(PlayerData[Slot], Data)
            end
        end
        for _, SlotSuccess in pairs (PlayerSuccess) do
            if not SlotSuccess then
                DataLoaded = false
            end
        end
        if DataLoaded then
            print("ServerStorage.Modules.DataStoreScript - " .. Player.Name .. "'s Data Successfully Loaded!")
        end
    end
end

function DataStoreScript.PlayerRemoving(Player)
    if DataStoreScript.DataLoaded[Player.UserId] == true then
        local DataStore = DataStoreService:GetDataStore(Player.UserId)
        for _, Slot in pairs (Slots) do
            local Success = DataStoreScript.SetAsync(DataStore, "Slot " .. Slot, DataStoreScript.Data[Player.UserId][Slot], 3)
            if Success then
                print("ServerStorage.Modules.DataStoreScript - " .. Player.Name .. "'s Slot " .. Slot .. " Saved!")
            end
        end
    end
    DataStoreScript.DataLoaded[Player.UserId] = nil
    DataStoreScript.Data[Player.UserId] = nil
end

function DataStoreScript.BindToClose()
    for _, Player in pairs (Players:GetPlayers()) do
        DataStoreScript.PlayerRemoving(Player)
    end
end

function DataStoreScript.Start()
    if IsServer then
        Players.PlayerAdded:Connect(DataStoreScript.PlayerAdded)
        Players.PlayerRemoving:Connect(DataStoreScript.PlayerRemoving)
        game.OnClose = DataStoreScript.BindToClose()
        ScriptRemote.OnServerInvoke = function(DataStoreFunction, Variables) -- Variables must be a table.
            local ReturnVariables = nil
            if DataStoreScript.ClientFunc[DataStoreFunction] then
                ReturnVariables = DataStoreScript.ClientFunc[DataStoreFunction](Variables)
            end
            return ReturnVariables
        end
    else warn("ServerStorage.Modules.DataStoreScript - Script is running locally?")
    end
end
return DataStoreScript