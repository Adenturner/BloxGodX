-- BloxGodX.lua
-- JakeThread™ 8-Core GUI Loader 🔥 by @Adenturner

local repo = "https://raw.githubusercontent.com/Adenturner/BloxGodX/main/"
local files = {
    "engine/thread_engine.lua",
    "gui/core_gui.lua",
    "modules/autofarm.lua",
    "modules/boss.lua",
    "modules/esp.lua",
    "modules/devilfruit.lua",
    "modules/teleport.lua",
    "modules/stats.lua",
    "modules/raid.lua",
    "modules/misc.lua",
}

local loaded = {}
for _, file in ipairs(files) do
    local src = game:HttpGet(repo .. file)
    loaded[file] = loadstring(src)()
end

-- Thread Engine Boot
local Engine = loaded["engine/thread_engine.lua"]
Engine.start()

-- Module Registration
for name, module in pairs(loaded) do
    if name:match("modules/") then
        Engine.register(name, module)
    end
end

-- GUI
loaded["gui/core_gui.lua"]()
