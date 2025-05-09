-- modules/devilfruit.lua
-- Fruit Finder + Notifier + Teleport Sniper (Basic)

return function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local HRP = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        return char:WaitForChild("HumanoidRootPart")
    end

    local function notify(fruitName)
        game.StarterGui:SetCore("SendNotification", {
            Title = "🍇 Devil Fruit Detected!",
            Text = fruitName .. " is nearby!",
            Duration = 5
        })
    end

    local function teleportTo(fruit)
        if fruit and fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
            HRP().CFrame = fruit.Handle.CFrame + Vector3.new(0, 3, 0)
        end
    end

    return function()
        if not _G.BloxGod.Running then return end

        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Tool") and v.Name:lower():find("fruit") and v:FindFirstChild("Handle") then
                notify(v.Name)
                teleportTo(v)
                wait(1) -- avoid spamming
            end
        end
    end
end
