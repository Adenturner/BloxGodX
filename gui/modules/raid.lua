-- modules/raid.lua
-- Auto Raid Start / Entry Trigger (Basic)

return function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local HRP = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        return char:WaitForChild("HumanoidRootPart")
    end

    local function findRaidAltar()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name:lower():find("altar") then
                return obj
            end
        end
    end

    local function teleportToRaid()
        local altar = findRaidAltar()
        if altar then
            HRP().CFrame = altar.CFrame + Vector3.new(0, 3, 0)
        end
    end

    local function autoStart()
        local altar = findRaidAltar()
        if altar then
            fireclickdetector(altar:FindFirstChildWhichIsA("ClickDetector"))
        end
    end

    return function()
        if not _G.BloxGod.Running then return end
        teleportToRaid()
        wait(1)
        autoStart()
    end
end
