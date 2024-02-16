-- Save this as 'mpv_history.lua' in your mpv scripts directory
-- The log will be saved to the mpv default config directory

local HISTFILE = (os.getenv("APPDATA") or os.getenv("HOME") .. "/.config") .. "/mpv/mpv_history.log"

mp.register_event("file-loaded", function()
	local path = mp.get_property("path")
	local working_directory = mp.get_property("working-directory")
	local absolute_path = working_directory .. "/" .. path

	local logfile = io.open(HISTFILE, "a+")
	-- logfile:write(("[%s] %s\n"):format(os.date("%d/%b/%y %X"), absolute_path))
	logfile:write(("%s\t\t\t%s\n"):format(os.date("%d/%b/%y %X"), absolute_path))
	logfile:close()
end)
