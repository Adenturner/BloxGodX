-- modules/boss.lua
-- Auto Boss Finder + Killer

return function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local HRP = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        return char:WaitForChild("HumanoidRootPart")
    end

    local function getBoss()
        for _, npc in ipairs(workspace:GetDescendants()) do
            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                local name = npc.Name:lower()
                if name:find("boss") or name:find("don") or name:find("king") or name:find("captain") then
                    if npc.Humanoid.Health > 0 then
                        return npc
                    end
                end
            end
        end
        return nil
    end

    local function killBoss(boss)
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if not tool then return end
        repeat
            HRP().CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
            tool:Activate()
            wait(0.2)
        until not boss or boss.Humanoid.Health <= 0 or not _G.BloxGod.Running
    end

    return function()
        if not _G.BloxGod.Running then return end
        local boss = getBoss()
        if boss then
            killBoss(boss)
        end
    end
end
