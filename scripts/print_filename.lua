-- Save this file as `~/.config/mpv/scripts/print_filename.lua`
mp.add_key_binding("F5", "print_filename", function()
	local filename = mp.get_property("path")
	local timestamp = mp.get_property_osd("playback-time")
	print("Enter a name for the file: ")
	local input = io.read()
	local filename_with_timestamp_and_input = filename .. "-" .. timestamp .. "-" .. input
	os.execute("touch '/tmp/" .. filename_with_timestamp_and_input .. "'")
	print("Saved empty file with name: " .. filename_with_timestamp_and_input)
end)
