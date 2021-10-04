local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local function CreateCloudScript(Object, StartingTransparency, Color, TweenTime, CloudTime, Vect3, OrientVect3, EndingTransparency, SizeScale)
    local Cloud = Object:Clone()
    Cloud.Name = "Cloud"
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
    Cloud.Transparency = StartingTransparency
    Cloud.Position = Object.Position
    TweenService:Create(Cloud, TweenInfo.new(TweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = Cloud.Position + Vect3, Orientation = OrientVect3, Transparency = EndingTransparency, Size = Cloud.Size / SizeScale}):Play()
    Debris:AddItem(Cloud, 1)
end
return CreateCloudScript