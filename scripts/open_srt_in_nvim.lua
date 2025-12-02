-- Script to open current subtitle file in Neovim
-- Save this as ~/.config/mpv/scripts/open_srt_in_nvim.lua

local utils = require("mp.utils")
local msg = require("mp.msg")

function get_current_sub_path()
	-- Try to get the currently selected subtitle track
	local track_list = mp.get_property_native("track-list")
	local sub_path = nil

	-- First check currently selected sub
	local current_sub_id = mp.get_property_number("current-tracks/sub/id")

	if current_sub_id then
		for _, track in ipairs(track_list) do
			if track.type == "sub" and track.id == current_sub_id then
				if track.external and track.external_filename then
					return track.external_filename
				end
			end
		end
	end

	-- If no subtitle is selected, look for any external subs
	for _, track in ipairs(track_list) do
		if track.type == "sub" and track.external and track.external_filename then
			return track.external_filename
		end
	end

	return nil
end

function open_sub_in_nvim()
	local sub_path = get_current_sub_path()

	if not sub_path then
		msg.warn("No external subtitle file found")
		return
	end

	-- Construct the command to open neovim in a new terminal
	local cmd
	if os.getenv("TERM") then
		-- For Linux/macOS
		cmd = string.format("$TERMINAL -e nvim '%s' &", sub_path)
	else
		-- For Windows (requires Windows Terminal)
		cmd = string.format("wt nvim '%s'", sub_path)
	end

	-- Execute the command
	local result = utils.subprocess({
		args = { "sh", "-c", cmd },
		playback_only = false,
	})

	if result.error then
		msg.error("Failed to open subtitle in neovim: " .. (result.error or "unknown error"))
	end
end

-- Bind the 'o' key to open subtitle in neovim
mp.add_key_binding("o", "open-sub-in-nvim", open_sub_in_nvim)
