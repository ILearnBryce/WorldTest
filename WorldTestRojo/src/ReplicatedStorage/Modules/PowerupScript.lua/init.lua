local PowerupScript = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Audio = ReplicatedStorage:WaitForChild("Audio")
local SFX = Audio:WaitForChild("SFX")
local Util = ReplicatedStorage:WaitForChild("Util")
local CreateCloudScript = require("")

function CreateClouds(Character, Powerup)

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