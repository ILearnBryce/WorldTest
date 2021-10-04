local DialogScript = {}
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Character = Player.Character
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local RunDialog = script.RunDialog
local DialogRunning = nil
local InDialog = false
local ClosingDialog = false
local IndicatorShown = false
local Dead = false

function DialogScript.StartDialog()
    if not InDialog and not ClosingDialog then
    InDialog = true
    end
end
function DialogScript.CloseDialog()
    if InDialog and not ClosingDialog then
    ClosingDialog = true
    InDialog = false
    -- Put things here lol
    ClosingDialog = false
    end
end
function DialogScript.ShowIndicator()
    if not IndicatorShown then
        IndicatorShown = true
    end
end

function DialogScript.HideIndicator()
    if IndicatorShown then
        IndicatorShown = false
    end
end

function DialogScript.Start()
    Player.CharacterAdded:Connect(function(LoadedCharacter)
        Character = LoadedCharacter
        Humanoid = Character:WaitForChild("Humanoid")
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        Dead = false
        Humanoid.Died:Connect(function()
            Dead = true
        end)
    end)
    local RunServiceLoop = false
    RunService:BindToRenderStep("DialogMagnitudeCheck", Enum.RenderPriority.First.Value, function()
        if RunServiceLoop == false then
            RunServiceLoop = true
            if not Dead then
                local FoundDialog = false
                for _, DialogCharacter in pairs (workspace.Engine.DialogCharacters) do
                    if DialogCharacter:FindFirstChild("Dialog") ~= nil then
                        local SeekDistance = DialogCharacter:FindFirstChild("Dialog"):FindFirstChild("SeekDistance").Value
                        if DialogCharacter:FindFirstChild("HumanoidRootPart") ~= nil then 
                            DialogCharacter = DialogCharacter:FindFirstChild("HumanoidRootPart").Position 
                        end
                        if (HumanoidRootPart.Position - DialogCharacter.Position).magnitude <= SeekDistance then
                            DialogRunning = DialogCharacter:FindFirstChild("Dialog")
                            DialogScript.ShowIndicator()
                        end
                    end
                end
                if not FoundDialog then
                    DialogScript.CloseDialog()
                    DialogScript.HideIndicator()
                end
            else
                DialogScript.CloseDialog()
                DialogScript.HideIndicator()
            end
            RunServiceLoop = false
        end
    end)
end
return DialogScript