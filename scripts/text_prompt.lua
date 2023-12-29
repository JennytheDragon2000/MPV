-- text_prompt.lua

local msg = require("mp.msg")
local utils = require("mp.utils")

function text_input_prompt()
	local res, input = mp.get_property_osd("osd-input-text")
	if res == "yes" then
		mp.osd_message("Input: " .. input)
		mp.set_property("osd-input-text", "")
		return
	end

	local result, text = mp.get_property_osd("osd-bar")
	if result == "yes" then
		mp.set_property("osd-bar", "")
		mp.osd_message("Enter text:")
		mp.set_property("osd-input-text", "")
	else
		mp.commandv("script-message", "osc-visibility", "bar")
	end
end

mp.add_key_binding(nil, "input-text-prompt", text_input_prompt)
