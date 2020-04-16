function focusX(val, focusOld, id, askFirst)
	return function()
		print("finding " .. id)
		local app = hs.application.get(id)
		print(app);
		if app then
			focusOld()
		elseif not askFirst() then
			focusOld()
		else
			 -- print(dump(hs.sound.systemSounds()))
			-- { [1] = Submarine [2] = Ping [3] = Purr [4] = Hero [5] = Funk [6] = Pop [7] = Basso [8] = Sosumi
			--   [9] = Glass [10] = Blow [11] = Bottle [12] = Frog [13] = Tink [14] = Morse }
			local sound = hs.sound.getByName("Morse")
			sound:volume(0.2)
			sound:play()

			-- local notification = hs.notify.new(function() focusOld() end, {
			--	title = "Run " ..  val.name .. "?",
			--	hasActionButton = true,
			--	actionButtonTitle = "Open",
			--	withdrawAfter = 0.1
			-- })

			-- notification:send()
		end

	end
end

function bindHotkeys(apps)
	for key, val in pairs(apps) do  -- Table iteration.
	    local focusFn
	    local app

	    if val.bundleId then
	        focusFn = utils.focusAppByBundleId(val.bundleId)
	        if val.askFirst ~= nil then
				focusFn = focusX(val, focusFn, val.bundleId, val.askFirst)
			end
	    else
	        focusFn = utils.focusApp(val.name)
	        if val.askFirst ~= nil then
				focusFn = focusX(val, focusFn, val.name, val.askFirst)
			end
	    end



	    if focusFn then
	        hs.hotkey.bind(utils.hyper, val.key, focusFn)
	    end
	end
end