-- modules/teleport.lua
-- Simple Predefined Location Teleport GUI

return function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local HRP = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        return char:WaitForChild("HumanoidRootPart")
    end

    local locations = {
        ["Starter Island"] = Vector3.new(100, 10, 200),
        ["Jungle"] = Vector3.new(-1200, 20, 300),
        ["Marine Fortress"] = Vector3.new(-4000, 100, 2000),
        ["Skylands"] = Vector3.new(-5000, 750, -1000),
        ["Colosseum"] = Vector3.new(-1500, 50, -3000),
    }

    local function teleportTo(location)
        if locations[location] then
            HRP().CFrame = CFrame.new(locations[location])
        end
    end

    return function()
        if not _G.BloxGod.Running then return end
        -- Optional future: attach GUI button listener here
        -- For now, default teleport to Starter Island
        teleportTo("Starter Island")
    end
end
