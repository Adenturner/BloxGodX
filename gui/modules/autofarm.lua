-- modules/autofarm.lua
-- AutoFarm: Quest Grab + Mob Kill Loop + Mastery Switch (Basic)

return function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HRP = Character:WaitForChild("HumanoidRootPart")
    local QuestFolder = workspace:WaitForChild("QuestNPCs", 10) or workspace

    local function getNearestQuest()
        local shortest, npc = math.huge, nil
        for _, v in pairs(QuestFolder:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                local dist = (v.HumanoidRootPart.Position - HRP.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    npc = v
                end
            end
        end
        return npc
    end

    local function teleportTo(pos)
        HRP.CFrame = CFrame.new(pos)
    end

    local function attackTarget(enemy)
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if not tool then return end
        repeat
            tool:Activate()
            wait(0.1)
        until not enemy or enemy.Humanoid.Health <= 0 or not _G.BloxGod.Running
    end

    local function getNearestEnemy()
        local closest, dist = nil, math.huge
        for _, mob in ipairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local d = (mob.PrimaryPart.Position - HRP.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = mob
                end
            end
        end
        return closest
    end

    -- MAIN THREAD LOOP
    return function()
        if not _G.BloxGod.Running then return end

        local npc = getNearestQuest()
        if npc then teleportTo(npc.HumanoidRootPart.Position + Vector3.new(0, 5, 0)) end

        wait(1)

        local enemy = getNearestEnemy()
        if enemy then
            teleportTo(enemy.PrimaryPart.Position + Vector3.new(0, 5, 0))
            attackTarget(enemy)
        end
    end
end
