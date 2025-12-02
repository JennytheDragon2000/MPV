
local start_time = nil
local output_dir = os.getenv("HOME") .. "/clips"  -- change if you want

-- make sure the folder exists
os.execute("mkdir -p " .. output_dir)

-- Set start of clip
mp.add_key_binding("s", "set_start_time", function()
    start_time = mp.get_property_number("time-pos")
    if start_time then
        mp.osd_message("Clip start set at: " .. string.format("%.2f", start_time))
    end
end)

-- Set end & save
mp.add_key_binding("e", "save_clip", function()
    if not start_time then
        mp.osd_message("Start time not set!")
        return
    end
    
    local end_time = mp.get_property_number("time-pos")
    if not end_time or end_time <= start_time then
        mp.osd_message("Invalid end time")
        return
    end

    local input = mp.get_property("path")

    -- filename using timestamp
    local output = string.format(
        "%s/clip_%d_%d.mp4",
        output_dir, start_time, end_time
    )
    
    local command = string.format(
        'ffmpeg -hide_banner -loglevel error -ss %.2f -to %.2f -i "%s" -c copy "%s"',
        start_time, end_time, input, output
    )

    os.execute(command)

    mp.osd_message("Clip saved: " .. output)
    start_time = nil
end)

