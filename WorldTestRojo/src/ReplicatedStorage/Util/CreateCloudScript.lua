local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local function CreateCloudScript(Object, Color, TweenTime, CloudTime, Vect3, Orientation, Transparency, SizeScale)
    local Cloud = Object:Clone()
    Cloud.Parent = workspace
    for _, Item in pairs (Cloud:GetChildren()) do
        Item:Destroy()
    end
    if Cloud:IsA("MeshPart") then
        Cloud.TextureID = ""
    elseif Cloud:IsA("UnionOperation") then
        Cloud.UsePartColor = true
    end
    Cloud.Color = Color

end
return CreateCloudScript