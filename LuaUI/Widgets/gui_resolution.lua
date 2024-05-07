function widget:GetInfo()
	return {
		name      = "Window Frustration Keys",
		desc      = "Changes your window settings",
		author    = "GoogleFrog",
		date      = "7 April 2024",
		license   = "GPL",
		layer     = 0,
		enabled   = true,
	}
end

include("keysym.h.lua")

function widget:KeyPress(key)
	Spring.Echo("Key", key)
	local screenX, screenY = Spring.GetScreenGeometry()
	
	if key == KEYSYMS.Z then
		Spring.Echo("Setting Borderless")
		Spring.SetConfigInt("XResolutionWindowed", screenX, false)
		Spring.SetConfigInt("YResolutionWindowed", screenY, false)
		Spring.SetConfigInt("WindowPosX", 0, false)
		Spring.SetConfigInt("WindowPosY", 0, false)
		Spring.SetConfigInt("WindowBorderless", 1, false)
		Spring.SetConfigInt("Fullscreen", 1, false)
	elseif key == KEYSYMS.X then
		Spring.Echo("Setting Windowed")
	
		local winSizeX, winSizeY, winPosX, winPosY = Spring.GetViewGeometry()
		Spring.Echo(winSizeX, winSizeY, winPosX, winPosY)

		-- Windowed mode does not work at all, but as far as I can tell it should.
		Spring.SetConfigInt("Fullscreen", 0, false)
		Spring.SetConfigInt("WindowBorderless", 0, false)
		winPosY = screenY - winPosY - winSizeY

		if winPosY > 10 then
			-- Window is not stuck at the top of the screen
			Spring.SetConfigInt("WindowPosX", math.min(winPosX, screenX - 50), false)
			Spring.SetConfigInt("WindowPosY", math.min(winPosY, screenY - 50), false)
			Spring.SetConfigInt("XResolutionWindowed",  math.min(winSizeX, screenX), false)
			Spring.SetConfigInt("YResolutionWindowed",  math.min(winSizeY, screenY - 50), false)
		else
			-- Reset window to screen centre
			Spring.SetConfigInt("WindowPosX", screenX/4, false)
			Spring.SetConfigInt("WindowPosY", screenY/8, false)
			Spring.SetConfigInt("XResolutionWindowed", screenX/2, false)
			Spring.SetConfigInt("YResolutionWindowed", screenY*3/4, false)
		end
	
	elseif key == KEYSYMS.C then
		Spring.Echo("Setting Fullscreen")
		Spring.SetConfigInt("XResolution", screenX, false)
		Spring.SetConfigInt("YResolution", screenY, false)
		Spring.SetConfigInt("Fullscreen", 1, false)
	end
end

function widget:Initialize()
	Spring.Echo("WIDGET FOUND")
end