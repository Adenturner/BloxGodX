-- gui/core_gui.lua
-- Minimal GUI Core: Draggable Window + FPS Monitor

return function()
    local Player = game.Players.LocalPlayer
    local GUI = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    GUI.Name = "BloxGodX"

    local Frame = Instance.new("Frame", GUI)
    Frame.Size = UDim2.new(0, 300, 0, 400)
    Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Active = true
    Frame.Draggable = true

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "🔥 BloxGodX Control Hub"
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18

    -- FPS Monitor
    local FPS = Instance.new("TextLabel", Frame)
    FPS.Position = UDim2.new(0, 0, 0, 30)
    FPS.Size = UDim2.new(1, 0, 0, 20)
    FPS.Text = "FPS: ..."
    FPS.TextColor3 = Color3.fromRGB(150, 255, 150)
    FPS.BackgroundTransparency = 1
    FPS.TextSize = 14

    game:GetService("RunService").RenderStepped:Connect(function()
        FPS.Text = "FPS: " .. math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
    end)
end
