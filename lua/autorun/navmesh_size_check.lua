-- Simple addon for nextbot developers
-- or for those that want to know what size they're aimming for GetSizeX / Y function

if CLIENT then
	hook.Add("Initialize", "HelloMessage", function()
		local clrGreen = Color(0, 255, 0)
		local clrWhite = Color(255, 255, 255)

		timer.Simple(6, function()
			chat.AddText(clrGreen, "[Navmesh Size Checker] ", clrWhite, "Type !navsize to check the size of the Navmesh area under your crosshairs.")
		end)
	end)
end

hook.Add("PlayerSay", "NavmeshSizeCommand", function(ply, text, isTeam)
	if string.lower( text ) == "!navsize" then
		-- Use a trace and HitPos to get the current NavMesh we are looking at
		local trace = ply:GetEyeTraceNoCursor()
		local cursorPos = trace.HitPos
		local navEdit = GetConVar( "nav_edit" ):GetBool()
		local navArea = navmesh.GetNavArea( cursorPos, 30 )

		if !navEdit then ply:PrintMessage( HUD_PRINTTALK, "nav_edit 1 is required!" ) return end

		if navArea then
			-- Print the size of the Navmesh area
			local sizeX = navArea:GetSizeX()
			local sizeY = navArea:GetSizeY()
			ply:PrintMessage( HUD_PRINTTALK, "Navmesh area size: Width = " .. sizeX .. ", Length = " .. sizeY )

		else

			ply:PrintMessage( HUD_PRINTTALK, "No Navmesh detected or area not found under crosshairs." )
		end

		return ""
	end
end)