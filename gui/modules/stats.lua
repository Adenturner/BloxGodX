-- modules/stats.lua
-- Auto Stat Allocator (based on user config or default)

return function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("AddPoint")

    -- You can customize this distribution as needed
    local statPriority = {
        ["Melee"] = 1,
        ["Defense"] = 2,
        ["Sword"] = 3,
        ["Gun"] = 0,
        ["Blox Fruit"] = 4,
    }

    local function getStatOrder()
        local order = {}
        for stat, weight in pairs(statPriority) do
            table.insert(order, { name = stat, weight = weight })
        end
        table.sort(order, function(a, b) return a.weight > b.weight end)
        return order
    end

    return function()
        if not _G.BloxGod.Running then return end
        if not Remote then return end

        local order = getStatOrder()
        for _, stat in ipairs(order) do
            for i = 1, 5 do -- distribute 5 per stat per frame (tweak as needed)
                Remote:InvokeServer(stat.name)
            end
        end
    end
end
