utils = require './windows'
require './utils'

function always()
	return true
end

function utils.reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

local layout = hs.keycodes.currentLayout()
if (string.find(layout, "Swedish")) then
    hs.eventtap.keyStroke({}, 'f3')
    utils.reloadConfig({os.getenv("HOME") .. "/.hammerspoon/init.lua"})
else

    hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", utils.reloadConfig):start()

    -- Window position and sizing
    hs.hotkey.bind(utils.hyper, "Left", utils.alignLeft)
    hs.hotkey.bind(utils.hyper, "Right", utils.alignRight)
    hs.hotkey.bind(utils.viper, "Up", utils.alignUp)
    hs.hotkey.bind(utils.viper, "Down", utils.alignDown)
    hs.hotkey.bind(utils.hyper, "M", utils.maximize)
    hs.hotkey.bind(utils.hyper, "Up", utils.grow)
    hs.hotkey.bind(utils.hyper, "Down", utils.shrink)
    hs.hotkey.bind(utils.hyper, "/", utils.showHelium)
    hs.hotkey.bind(utils.hyper, ".", utils.showHelium2)

    -- App switching
    bindHotkeys({
        { key = "2", askFirst = always, name = "Firefox" },
        { key = "Q", askFirst = always, name = "Slack"},
        { key = "W", askFirst = always, bundleId = "com.microsoft.VSCode"},
        { key = "E", name = "Spotify"},        
        { key = "S", name = "Sublime Text"},        
        { key = "D", name = "iTerm"},
        { key = "F", name = "Helium"},
        { key = "Z", name = "Finder"},        
        { key = "X", askFirst = always, name = "Chrome", bundleId= 'com.google.Chrome'},                
        { key = "1", name = "Notes"},
        { key = "R", name = "Reminders"},
    })

    hs.hotkey.bind({}, 'f13', function()
        hs.eventtap.keyStroke({'alt'}, 'k', 5)
        hs.eventtap.keyStroke({}, 'a', 5)
    end)

    hs.hotkey.bind({'shift'}, 'f13', function()
        hs.eventtap.keyStroke({'alt'}, 'k', 5)
        hs.eventtap.keyStroke({'shift'}, 'a', 5)
    end)
    ---
    hs.hotkey.bind({}, 'f14', function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({}, 'a', 5)
    end)

    hs.hotkey.bind({'shift'}, 'f14', function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({'shift'}, 'a', 5)
    end)
    ---
    hs.hotkey.bind({}, 'f15', function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({}, 'o', 5)
    end)

    hs.hotkey.bind({'shift'}, 'f15', function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({'shift'}, 'o', 5)
    end)

    -------------------
    hs.hotkey.bind(utils.hyper, '[', function()        
        hs.eventtap.keyStroke({'alt'}, 'a', 5)
    end)

    hs.hotkey.bind(utils.viper, '[', function()        
        hs.eventtap.keyStroke({'alt', 'shift'}, 'a', 5)
    end)

    hs.hotkey.bind(utils.hyper, "'", function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({}, 'a', 5)
    end)


    hs.hotkey.bind(utils.viper, "'", function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({'shift'}, 'a', 5)
    end)

    hs.hotkey.bind(utils.hyper, ';', function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({}, 'o', 5)
    end)

    hs.hotkey.bind(utils.viper, ';', function()
        hs.eventtap.keyStroke({'alt'}, 'u', 5)
        hs.eventtap.keyStroke({'shift'}, 'o', 5)
    end)

    hs.hotkey.bind(utils.hyper, 'space', function()
        local win = hs.window.frontmostWindow()
        win:centerOnScreen();
    end)

    hs.window.animationDuration = 0

    hs.notify.new({
        title="Hammerspoon",
        informativeText="Config loaded"
    }):send()
end

