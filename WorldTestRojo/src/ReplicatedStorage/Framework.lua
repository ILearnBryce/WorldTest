local Framework = {}
local MarketPlaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local IsServerServer = RunService:IsServer()
local StartingPoints = {
    ["World Test"] = "Checkpoint_WTT_01",
    ["Engine"] = "Checkpoint_ENG_01",
    ["Sky Emporium"] = "Checkpoint_HSE_01",
    ["World 1"] = "Checkpoint_W01_01",
    ["World 2"] = "Checkpoint_W02_01",
    ["World 3"] = "Checkpoint_W03_01",
    ["World 4"] = "Checkpoint_W04_01"
}
local PlaceName = MarketPlaceService:GetProductInfo(game.PlaceId).Name

if IsServerServer then
    local Modules = ServerStorage:WaitForChild("Modules")
    for _, Module in pairs (Modules:GetChildren()) do
        if Module.ClassName == "ModuleScript" then
            local RequireModule = require(Module)
            RequireModule.Start()
        end
    end
else
    local Modules = ReplicatedStorage:WaitForChild("Modules")
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    Character.PrimaryPart = Character.HumanoidRootPart
    Character:SetPrimaryPartCFrame(workspace.Engine.SpawnLocations[StartingPoints[PlaceName]].CFrame + Vector3.new(0,25,0))
    for _, Module in pairs (Modules:GetChildren()) do
        if Module.ClassName == "ModuleScript" then
            local RequireModule = require(Module)
            RequireModule.Start()
        end
    end
end

return Framework