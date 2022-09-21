function focusX(val, focusOld, id, askFirst)
	return function()

		local app = hs.application.get(id)


		if app then
			print("found " .. id)
			focusOld()
		elseif not askFirst() then
			print("did not find " .. id)
			focusOld()
		else
			print("did not find and won't start " .. id)
			local sound = hs.sound.getByName("Morse")
			sound:volume(0.2)
			sound:play()
		end

	end
end

function bindHotkeys(apps)
	for key, val in pairs(apps) do
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