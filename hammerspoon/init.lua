utils = require './windows'
require './utils'

function always()
	return true
end


local layout = hs.keycodes.currentLayout()
if (string.find(layout, "Swedish")) then

    hs.notify.new({
        title="Hammerspoon",
        informativeText="Change to english layout please"
    }):send()

    hs.timer.doAfter(5, function()
        utils.reloadConfig({os.getenv("HOME") .. "/.hammerspoon/init.lua"})
    end)

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

    -- App switching
    bindHotkeys({
        { key = "1", name = "Obsidian" },
        { key = "2", askFirst = always, name = "Firefox" },

        { key = "Q", askFirst = always, name = "Slack"},
        { key = "W", bundleId = "com.microsoft.VSCode"},
        { key = "E", name = "Spotify"},
        -- { key = "A", askFirst = always, name = "Brave Browser" },
        { key = "S", name = "Sublime Text"},
        { key = "D", name = "iTerm"},

        -- { key = "F", name = "Helium"},

        { key = "Z", name = "Finder"},
        { key = "X", askFirst = always, name = "Chrome", bundleId= 'com.google.Chrome'},
        -- { key = "R", name = "Reminders"},
    })

    hs.hotkey.bind(utils.hyper, "v", function()
        local shell_command = "date +\"Week: %U\""
        local weekNumber = hs.execute(shell_command)
        hs.notify.show(weekNumber, "", "")
    end)

    hs.hotkey.bind(utils.hyper, 'return', function()

        function resize(id, screenId, callback)
            local screens = hs.screen.allScreens()
            local app = hs.application.get(id)
            if app then
                local wins = app:allWindows()
                print(id)
                print(#wins)
                if #wins > 0 then
                    local screenFrame = screens[screenId]:frame()
                    callback(id, screenFrame, wins[1])
                    wins[1]:setFrame(screenFrame)
                    wins[1]:raise()
                end
            end
        end

        resize("com.google.Chrome", 1, function(id, frame, win)
            frame.w = frame.w * 0.5

        end)

        resize("Firefox", 2, function(id, frame, win)
            frame.w = frame.w * 0.5
        end)

        resize("Slack", 1, function(id, frame, win)
            frame.x = frame.x + frame.w * 0.33
            frame.w = frame.w * 0.67

        end)


        resize("com.microsoft.VSCode", 1, function(id, frame, win)
            frame.x = frame.w * 0.33
            frame.w = frame.w * 0.67
            wins[1]:focus()
        end)




    end)

    ------------------- swedish characters -------------------
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

