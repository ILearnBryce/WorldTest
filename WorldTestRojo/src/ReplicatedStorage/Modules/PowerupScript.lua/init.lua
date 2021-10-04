local PowerupScript = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = game:GetService("PlayerGui").MainUI
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Audio = ReplicatedStorage:WaitForChild("Audio")
local SFX = Audio:WaitForChild("SFX")
local Util = ReplicatedStorage:WaitForChild("Util")
local CreateCloudScript = require(Util:WaitForChild("CreateCloudScript"))
local UI = ReplicatedStorage:WaitForChild("UI")
local PowerupList = UI:WaitForChild("PowerupList"):Clone()
local AlphaRocketScriptNR = script:WaitForChild("AlphaRocketScript")
local BatteryScriptNR = script:WaitForChild("BatteryScript")
local BombScriptNR = script:WaitForChild("BombScript")
local DashPepperScriptNR = script:WaitForChild("DashPepperScript")
local ForceFieldScriptNR = script:WaitForChild("ForceFieldScript")
local JumpPowerScriptNR = script:WaitForChild("JumpPowerScript")
local MarbleScriptNR = script:WaitForChild("MarbleScript")
local AlphaRocketScript = require(AlphaRocketScriptNR)
local BatteryScript = require(BatteryScriptNR)
local BombScript = require(BombScriptNR)
local DashPepperScript = require(DashPepperScriptNR)
local ForceFieldScript = require(ForceFieldScriptNR)
local JumpPowerScript = require(JumpPowerScriptNR)
local MarbleScript = require(MarbleScriptNR)
PowerupList.Parent = MainUI

function CreateClouds(Character, Powerup)
    CreateCloudScript(Powerup, 0.4, Color3.new(1,1,1), 1, Vector3.new(0,7,0), Powerup.Orientation, 1, 1)
    for _, BodyPart in pairs(Character:GetChildren()) do
        if BodyPart:IsA("MeshPart") or BodyPart:IsA("UnionOperation") or BodyPart:IsA("BasePart") then
            CreateCloudScript(BodyPart, 0, Color3.new(1,1,1), 1, Vector3.new(0,5,0), Vector3.new(math.random(-180,180), math.random(-180,180), math.random(-180,180)), 1, 1/3)
        end
    end)
end
function PowerupScript.Start()
    Player.CharacterAdded:Connect(function(LoadedCharacter)
        Character = LoadedCharacter
        Humanoid = Character:WaitForChild("Humanoid")
        Humanoid.Touched:Connect(Hit, BodyPart)
            if BodyPart.Parent:IsA("Accoutrement") or BodyPart.Parent ~= Character then return end
            if Hit.Name == "AlphaRocket" then
            end
            if Hit.Name == "AlphaRocketChip" then
            end
            if Hit.Name == "Battery" then
            end
            if Hit.Name == "BatteryChip" then
            end
            if Hit.Name == "BatteryActivate" then
            end
            if Hit.Name == "Bomb" then
            end
            if Hit.Name == "BombChip" then
            end
            if Hit.Name == "DashPepper" then
            end
            if Hit.Name == "DashPepperPiece" then
            end
            if Hit.Name == "ForceField" then
            end
            if Hit.Name == "ForceFieldChip" then
            end
            if Hit.Name == "JumpPower" then
            end
            if Hit.Name == "JumpPowerChip" then
            end
            if Hit.Name == "Marble" then
            end
            if Hit.Name == "MarbleChip" then
            end
        end)
    end)
end
return PowerupScript