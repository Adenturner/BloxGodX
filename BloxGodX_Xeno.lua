-- BloxGodX_Xeno.lua
-- Xeno-Compatible Lightweight Loader (Safe Loadstring Fix)

print("✅ BloxGodX_Xeno - Init")

local repo = "https://raw.githubusercontent.com/Adenturner/BloxGodX/main/"

-- Manually load each module
local function safeLoad(name, path)
    print("📦 Loading:", name)
    local success, result = pcall(function()
        local src = game:HttpGet(repo .. path)
        local fn = loadstring(src)
        return fn and fn()
    end)
    if success and typeof(result) == "function" then
        print("✅ " .. name .. " loaded.")
        return result
    else
        warn("❌ " .. name .. " failed to load.")
        return nil
    end
end

local Engine = safeLoad("ThreadEngine", "engine/thread_engine.lua")
if Engine then Engine.start() end

local modules = {
    { name = "AutoFarm", path = "modules/autofarm.lua" },
    { name = "Boss", path = "modules/boss.lua" },
    { name = "ESP", path = "modules/esp.lua" },
    { name = "Fruit", path = "modules/devilfruit.lua" },
    { name = "Teleport", path = "modules/teleport.lua" },
    { name = "Stats", path = "modules/stats.lua" },
    { name = "Raid", path = "modules/raid.lua" },
    { name = "Misc", path = "modules/misc.lua" },
}

for _, mod in ipairs(modules) do
    local fn = safeLoad(mod.name, mod.path)
    if fn and Engine then
        Engine.register(mod.name, fn)
    end
end

-- Load Xeno GUI
local guiSrc = game:HttpGet(repo .. "gui/core_gui_xeno.lua")
local ok, guiFunc = pcall(loadstring, guiSrc)
if ok and typeof(guiFunc) == "function" then
    guiFunc()
    print("✅ GUI loaded.")
else
    warn("❌ GUI failed to load.")
end
