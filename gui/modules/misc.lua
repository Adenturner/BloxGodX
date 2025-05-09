-- modules/misc.lua
-- Anti-AFK, FPS Boost, Server Hop, Auto Leave, Reset, Low Ping

return function()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local VirtualUser = game:service("VirtualUser")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = Players.LocalPlayer

    -- Anti-AFK
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)

    -- FPS Boost
    local function boostFPS()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        Lighting.GlobalShadows = false
        settings().Rendering.QualityLevel = "Level01"
    end

    -- Server Hop
    local function serverHop()
        local servers = {}
        local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, v in pairs(req.data) do
            if v.playing < v.maxPlayers then
                table.insert(servers, v.id)
            end
        end
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    end

    -- Auto Leave on Danger
    local function dangerCheck()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            if char.Humanoid.Health < 20 then
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end
        end
    end

    -- Quick Reset
    local function resetChar()
        local char = LocalPlayer.Character
        if char then
            char:BreakJoints()
        end
    end

    -- Low Ping Mode
    local function lowPing()
        setfpscap(30)
        RunService:Set3dRenderingEnabled(false)
    end

    -- MAIN THREAD
    return function()
        if not _G.BloxGod.Running then return end
        boostFPS()
        dangerCheck()
        -- Optional: Add toggle state management if GUI inputs are added
    end
end
