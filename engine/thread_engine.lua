-- engine/thread_engine.lua
-- JakeThread™ v8: Simulated 8-Core Task Manager

local RunService = game:GetService("RunService")
local threads = {}

return {
    register = function(name, func)
        threads[name] = { func = func, enabled = true }
    end,
    toggle = function(name, state)
        if threads[name] then
            threads[name].enabled = state
        end
    end,
    start = function()
        RunService.Heartbeat:Connect(function()
            for _, t in pairs(threads) do
                if t.enabled then
                    coroutine.wrap(t.func)()
                end
            end
        end)
    end
}
