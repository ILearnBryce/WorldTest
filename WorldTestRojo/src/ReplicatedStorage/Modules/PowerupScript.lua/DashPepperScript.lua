local DashPepperScript = {
    RemovePowerups = {}
}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util = ReplicatedStorage:WaitForChild("Util")
local CreateCloudScript = require(Util:WaitForChild("CreateCloudScript"))
local UI = ReplicatedStorage:WaitForChild("UI")
local Pepper = UI:WaitForChild("Pepper")
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local RunServiceLoop = false
local Enabled = false
local PowerupNumber = 0

function DashPepperScript.Remove()
end
function DashPepperScript.Start(Time, Speed)
    if Enabled then
        DashPepperScript.RemovePowerups[PowerupNumber] = true
    end
    Enabled = true
    Character = Player.Character
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    PowerupNumber = PowerupNumber + 1
    Humanoid.Died:Connect(function()
        DashPepperScript.RemovePowerups[PowerupNumber] = true
        DashPepperScript.Remove()
    end)
    Humanoid.WalkSpeed = Speed
    RunService:UnBindFromRenderStep("DashPepperCloud")
    RunService:BindToRenderStep("DashPepperCloud", Enum.RenderPriority.First.Value, function()
        if Enabled and (Humanoid:GetState() == Enum.HumanoidStateType.FreeFall or Humanoid:GetState() == Enum.HumanoidStateType.Running or Humanoid:GetState() == Enum.HumanoidStateType.RunningNoPhysics) and Humanoid.MoveDirection ~= Vector3.new(0,0,0) and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and not RunServiceLoop then
            RunServiceLoop = true
            for _, BodyPart in pairs (Character:GetChildren()) do
                if BodyPart:IsA("MeshPart") or BodyPart:IsA("UnionOperation") or BodyPart:IsA("BasePart") then
                    CreateCloudScript(BodyPart, 0.4, Color3.new(1,0,0), 0.4, Vector3.new(0,0,0), BodyPart.Orientation, 1, 1)
                end
            end
            wait(0.1)
            RunServiceLoop = false
        end
    end)
    Pepper:Clone()
    Pepper.Parent = MainUI
end

script.Start:Event(DashPepperScript.Start)
return DashPepperScript