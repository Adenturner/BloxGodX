-- gui/core_gui_xeno.lua
-- Xeno-Safe GUI (no draggable)

return function()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local Player = Players.LocalPlayer
    local GUI = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    GUI.Name = "BloxGodX_Xeno"

    local Frame = Instance.new("Frame", GUI)
    Frame.Size = UDim2.new(0, 300, 0, 350)
    Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 0

    local dragging, dragInput, dragStart, startPos

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "BloxGodX [Xeno]"
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.SourceSansBold
end
