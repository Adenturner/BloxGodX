-- modules/esp.lua
-- Simple ESP: draws labels above players and mobs

return function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer

    local function createESP(instance, text, color)
        local Billboard = Instance.new("BillboardGui")
        Billboard.Adornee = instance
        Billboard.Size = UDim2.new(0, 100, 0, 40)
        Billboard.StudsOffset = Vector3.new(0, 3, 0)
        Billboard.AlwaysOnTop = true

        local Label = Instance.new("TextLabel", Billboard)
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = color
        Label.TextScaled = true
        Label.Font = Enum.Font.SourceSansBold

        Billboard.Parent = instance
    end

    local function updateESP()
        -- Clear old
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BillboardGui") and v.Name ~= "Ignore" then
                v:Destroy()
            end
        end

        -- Add player ESP
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                createESP(player.Character.HumanoidRootPart, player.Name, Color3.fromRGB(0, 255, 0))
            end
        end

        -- Add enemy ESP
        if workspace:FindFirstChild("Enemies") then
            for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") then
                    createESP(enemy.HumanoidRootPart, enemy.Name, Color3.fromRGB(255, 0, 0))
                end
            end
        end
    end

    return function()
        if not _G.BloxGod.Running then return end
        updateESP()
    end
end
