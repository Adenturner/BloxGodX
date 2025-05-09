-- BloxGodX_Xeno.lua
-- Xeno-Compatible Lightweight GUI Loader

local repo = "https://raw.githubusercontent.com/Adenturner/BloxGodX/main/"
local modules = {
    "modules/autofarm.lua",
    "modules/boss.lua",
    "modules/esp.lua",
    "modules/devilfruit.lua",
    "modules/teleport.lua",
    "modules/stats.lua",
    "modules/raid.lua",
    "modules/misc.lua",
}
local engine_code = game:HttpGet(repo .. "engine/thread_engine.lua")
local gui_code = game:HttpGet(repo .. "gui/core_gui_xeno.lua")

-- Fallback _G for Xeno
_G.BloxGod = _G.BloxGod or { Threads = {}, Running = true }

-- Boot JakeThread
local Engine = loadstring(engine_code)()
Engine.start()

-- Load & register each module
for _, path in ipairs(modules) do
    local src = game:HttpGet(repo .. path)
    local ok, fn = pcall(loadstring, src)
    if ok and typeof(fn) == "function" then
        local safeCall = pcall(function()
            Engine.register(path, fn())
        end)
    end
end

-- Load Xeno-safe GUI
pcall(function()
    loadstring(gui_code)()
end)
