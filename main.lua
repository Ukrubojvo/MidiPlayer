-- SUPPORT EXECUTOR : ALL
-- MADE BY .antilua.
local function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

local cloneref = missing("function", cloneref, function(...) return ... end)
local service = setmetatable({}, {
    __index = function(self, name)
        self[name] = cloneref(game:GetService(name))
        return self[name]
    end
})

local oldgame = game
local game = workspace.Parent
local run_service = service.RunService
local vim = service.VirtualInputManager
local uis = service.UserInputService
local players = service.Players
local player = players.LocalPlayer

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end
local GUIParent = gethui and gethui() or game.CoreGui

local key_map = {
    [21] = {keycode = Enum.KeyCode.One, ctrl = true},
    [22] = {keycode = Enum.KeyCode.Two, ctrl = true},
    [23] = {keycode = Enum.KeyCode.Three, ctrl = true},
    [24] = {keycode = Enum.KeyCode.Four, ctrl = true},
    [25] = {keycode = Enum.KeyCode.Five, ctrl = true},
    [26] = {keycode = Enum.KeyCode.Six, ctrl = true},
    [27] = {keycode = Enum.KeyCode.Seven, ctrl = true},
    [28] = {keycode = Enum.KeyCode.Eight, ctrl = true},
    [29] = {keycode = Enum.KeyCode.Nine, ctrl = true},
    [30] = {keycode = Enum.KeyCode.Zero, ctrl = true},
    [31] = {keycode = Enum.KeyCode.Q, ctrl = true},
    [32] = {keycode = Enum.KeyCode.W, ctrl = true},
    [33] = {keycode = Enum.KeyCode.E, ctrl = true},
    [34] = {keycode = Enum.KeyCode.R, ctrl = true},
    [35] = {keycode = Enum.KeyCode.T, ctrl = true},
    [36] = {keycode = Enum.KeyCode.One, shift = false}, [37] = {keycode = Enum.KeyCode.One, shift = true},
    [38] = {keycode = Enum.KeyCode.Two, shift = false}, [39] = {keycode = Enum.KeyCode.Two, shift = true},
    [40] = {keycode = Enum.KeyCode.Three, shift = false}, [41] = {keycode = Enum.KeyCode.Four, shift = false},
    [42] = {keycode = Enum.KeyCode.Four, shift = true}, [43] = {keycode = Enum.KeyCode.Five, shift = false},
    [44] = {keycode = Enum.KeyCode.Five, shift = true}, [45] = {keycode = Enum.KeyCode.Six, shift = false},
    [46] = {keycode = Enum.KeyCode.Six, shift = true}, [47] = {keycode = Enum.KeyCode.Seven, shift = false},
    [48] = {keycode = Enum.KeyCode.Eight, shift = false}, [49] = {keycode = Enum.KeyCode.Eight, shift = true},
    [50] = {keycode = Enum.KeyCode.Nine, shift = false}, [51] = {keycode = Enum.KeyCode.Nine, shift = true},
    [52] = {keycode = Enum.KeyCode.Zero, shift = false}, [53] = {keycode = Enum.KeyCode.Q, shift = false},
    [54] = {keycode = Enum.KeyCode.Q, shift = true}, [55] = {keycode = Enum.KeyCode.W, shift = false},
    [56] = {keycode = Enum.KeyCode.W, shift = true}, [57] = {keycode = Enum.KeyCode.E, shift = false},
    [58] = {keycode = Enum.KeyCode.E, shift = true}, [59] = {keycode = Enum.KeyCode.R, shift = false},
    [60] = {keycode = Enum.KeyCode.T, shift = false}, [61] = {keycode = Enum.KeyCode.T, shift = true},
    [62] = {keycode = Enum.KeyCode.Y, shift = false}, [63] = {keycode = Enum.KeyCode.Y, shift = true},
    [64] = {keycode = Enum.KeyCode.U, shift = false}, [65] = {keycode = Enum.KeyCode.I, shift = false},
    [66] = {keycode = Enum.KeyCode.I, shift = true}, [67] = {keycode = Enum.KeyCode.O, shift = false},
    [68] = {keycode = Enum.KeyCode.O, shift = true}, [69] = {keycode = Enum.KeyCode.P, shift = false},
    [70] = {keycode = Enum.KeyCode.P, shift = true}, [71] = {keycode = Enum.KeyCode.A, shift = false},
    [72] = {keycode = Enum.KeyCode.S, shift = false}, [73] = {keycode = Enum.KeyCode.S, shift = true},
    [74] = {keycode = Enum.KeyCode.D, shift = false}, [75] = {keycode = Enum.KeyCode.D, shift = true},
    [76] = {keycode = Enum.KeyCode.F, shift = false}, [77] = {keycode = Enum.KeyCode.G, shift = false},
    [78] = {keycode = Enum.KeyCode.G, shift = true}, [79] = {keycode = Enum.KeyCode.H, shift = false},
    [80] = {keycode = Enum.KeyCode.H, shift = true}, [81] = {keycode = Enum.KeyCode.J, shift = false},
    [82] = {keycode = Enum.KeyCode.J, shift = true}, [83] = {keycode = Enum.KeyCode.K, shift = false},
    [84] = {keycode = Enum.KeyCode.L, shift = false}, [85] = {keycode = Enum.KeyCode.L, shift = true},
    [86] = {keycode = Enum.KeyCode.Z, shift = false}, [87] = {keycode = Enum.KeyCode.Z, shift = true},
    [88] = {keycode = Enum.KeyCode.X, shift = false}, [89] = {keycode = Enum.KeyCode.C, shift = false},
    [90] = {keycode = Enum.KeyCode.C, shift = true}, [91] = {keycode = Enum.KeyCode.V, shift = false},
    [92] = {keycode = Enum.KeyCode.V, shift = true}, [93] = {keycode = Enum.KeyCode.B, shift = false},
    [94] = {keycode = Enum.KeyCode.B, shift = true}, [95] = {keycode = Enum.KeyCode.N, shift = false},
    [96] = {keycode = Enum.KeyCode.M, shift = false}, [97] = {keycode = Enum.KeyCode.M, shift = true},
    [98] = {keycode = Enum.KeyCode.U, ctrl = true}, [99] = {keycode = Enum.KeyCode.I, ctrl = true},
    [100] = {keycode = Enum.KeyCode.O, ctrl = true}, [101] = {keycode = Enum.KeyCode.P, ctrl = true},
    [102] = {keycode = Enum.KeyCode.A, ctrl = true}, [103] = {keycode = Enum.KeyCode.S, ctrl = true},
    [104] = {keycode = Enum.KeyCode.D, ctrl = true}, [105] = {keycode = Enum.KeyCode.F, ctrl = true},
    [106] = {keycode = Enum.KeyCode.G, ctrl = true}, [107] = {keycode = Enum.KeyCode.H, ctrl = true},
    [108] = {keycode = Enum.KeyCode.J, ctrl = true}
}

local events = {}
local tempo_events = {}
local current_tempo = 500000
local current_time = 0
local last_tick = 0
local sustain = false
local auto_sustain_enabled = false
local no_note_off_enabled = false
local random_note_enabled = false
local shift = false
local ctrl = false
local active_notes = {}
local note_on_stack = {}
local start_time = 0
local next_event_index = 1
local paused = false
local pause_time = 0
local pause_position = 0
local total_duration = 0
local midi_files = {}
local playback_speed = 1.0

local folder_name = "MIDI"

if not isfolder(folder_name) then
    makefolder(folder_name)
end

local function read_var_int(data, offset)
    local value = 0
    local bytes_read = 0
    while true do
        local byte = string.byte(data, offset + bytes_read)
        if not byte then break end
        bytes_read = bytes_read + 1
        value = bit32.bor(bit32.lshift(value, 7), bit32.band(byte, 0x7F))
        if bit32.band(byte, 0x80) == 0 then break end
    end
    return value, bytes_read
end

local function calculate_realtime_position(ticks, ticks_per_beat, tempo_changes)
    local current_tick = 0
    local current_time_ms = 0
    local current_tempo = 500000
    
    for _, tempo_event in ipairs(tempo_changes) do
        if tempo_event.tick <= ticks then
            local tick_diff = tempo_event.tick - current_tick
            current_time_ms = current_time_ms + (tick_diff * current_tempo / 1000) / ticks_per_beat
            
            current_tick = tempo_event.tick
            current_tempo = tempo_event.tempo
        else
            break
        end
    end
    
    local remaining_ticks = ticks - current_tick
    current_time_ms = current_time_ms + (remaining_ticks * current_tempo / 1000) / ticks_per_beat
    
    return current_time_ms / 1000
end

local function parse_midi_improved(data)
    local buffer = data
    local offset = 1
    local track_end_offset = 0
    local is_header_parsed = false
    local ticks_per_beat = 0
    local last_status_byte = nil
    local track_time = 0
    local note_on_stack = {}
    local parsed_events = {}
    local tempo_changes = {{tick = 0, tempo = 500000}}

    while true do
        if not is_header_parsed then
            if #buffer < 14 then break end
            if string.sub(buffer, 1, 4) ~= 'MThd' then break end
            ticks_per_beat = string.unpack(">H", buffer, 13)
            offset = 15
            is_header_parsed = true
        end

        if offset >= track_end_offset then
            if #buffer - offset + 1 < 8 then break end
            if string.sub(buffer, offset, offset + 3) ~= 'MTrk' then break end
            offset = offset + 4
            local track_length = string.unpack(">I4", buffer, offset)
            offset = offset + 4
            track_end_offset = offset + track_length - 1
            last_status_byte = nil
            track_time = 0
            note_on_stack = {}
        end

        if offset > track_end_offset then break end

        local delta, delta_bytes = read_var_int(buffer, offset)
        offset = offset + delta_bytes
        track_time = track_time + delta

        local status
        local status_byte = string.byte(buffer, offset)
        if not status_byte then break end

        if bit32.band(status_byte, 0x80) ~= 0 then
            last_status_byte = status_byte
            status = status_byte
            offset = offset + 1
        else
            if last_status_byte == nil then break end
            status = last_status_byte
        end

        local command = bit32.band(status, 0xF0)
        local channel = bit32.band(status, 0x0F)

        if command == 0x90 or command == 0x80 then
            local note_number = string.byte(buffer, offset)
            local velocity = string.byte(buffer, offset + 1)
            if not note_number or not velocity then break end
            offset = offset + 2

            local is_on = command == 0x90 and velocity > 0
            local key = tostring(note_number) .. ":" .. tostring(channel)

            if is_on then
                if note_on_stack[key] then
                    local prev = note_on_stack[key]
                    local length_ticks = track_time - prev.on_tick
                    if length_ticks > 0 then
                        local on_time = calculate_realtime_position(prev.on_tick, ticks_per_beat, tempo_changes)
                        local off_time = calculate_realtime_position(track_time, ticks_per_beat, tempo_changes)
                        table.insert(parsed_events, {
                            type = 'on',
                            note = prev.note_name,
                            vel = prev.velocity,
                            channel = prev.channel,
                            abs_time = on_time,
                            tick = prev.on_tick
                        })
                        table.insert(parsed_events, {
                            type = 'off',
                            note = prev.note_name,
                            channel = prev.channel,
                            abs_time = off_time,
                            tick = track_time
                        })
                    end
                    note_on_stack[key] = nil
                end
                note_on_stack[key] = {
                    on_tick = track_time,
                    velocity = velocity,
                    note_name = note_number,
                    channel = channel
                }
            else
                local prev = note_on_stack[key]
                if prev then
                    local length_ticks = track_time - prev.on_tick
                    if length_ticks > 0 then
                        local on_time = calculate_realtime_position(prev.on_tick, ticks_per_beat, tempo_changes)
                        local off_time = calculate_realtime_position(track_time, ticks_per_beat, tempo_changes)
                        table.insert(parsed_events, {
                            type = 'on',
                            note = prev.note_name,
                            vel = prev.velocity,
                            channel = prev.channel,
                            abs_time = on_time,
                            tick = prev.on_tick
                        })
                        table.insert(parsed_events, {
                            type = 'off',
                            note = prev.note_name,
                            channel = prev.channel,
                            abs_time = off_time,
                            tick = track_time
                        })
                    end
                    note_on_stack[key] = nil
                end
            end
        elseif command == 0xB0 then
            local controller_type = string.byte(buffer, offset)
            local value = string.byte(buffer, offset + 1)
            if not controller_type or not value then break end
            offset = offset + 2
            
            if controller_type == 64 then
                local control_time = calculate_realtime_position(track_time, ticks_per_beat, tempo_changes)
                table.insert(parsed_events, {
                    type = 'control',
                    vel = value,
                    abs_time = control_time,
                    tick = track_time
                })
            end
        elseif status == 0xFF then
            local meta_type = string.byte(buffer, offset)
            if not meta_type then break end
            offset = offset + 1
            
            local length, length_bytes = read_var_int(buffer, offset)
            offset = offset + length_bytes
            
            if meta_type == 0x51 and length == 3 then
                local b1, b2, b3 = string.byte(buffer, offset, offset + 2)
                if b1 and b2 and b3 then
                    local micro_per_beat = b1 * 65536 + b2 * 256 + b3
                    table.insert(tempo_changes, {tick = track_time, tempo = micro_per_beat})
                end
            end
            offset = offset + length
        else
            local data_len = (command == 0xC0 or command == 0xD0) and 1 or 2
            offset = offset + data_len
        end

        if offset > track_end_offset then
            offset = track_end_offset + 1
        end
    end

    for key, prev in pairs(note_on_stack) do
        local on_time = calculate_realtime_position(prev.on_tick, ticks_per_beat, tempo_changes)
        table.insert(parsed_events, {
            type = 'on',
            note = prev.note_name,
            vel = prev.velocity,
            channel = prev.channel,
            abs_time = on_time,
            tick = prev.on_tick
        })
    end

    table.sort(parsed_events, function(a, b) return a.abs_time < b.abs_time end)
    
    return parsed_events, tempo_changes
end

local function release_all_keys_except_spacebar()
    for _, k in pairs(active_notes) do
        vim:SendKeyEvent(false, k.keycode, false, game)
    end
    if ctrl then 
        vim:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
        ctrl = false 
    end
    if shift then 
        vim:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
        shift = false 
    end
    active_notes = {}
end

local function get_current_playback_position()
    if paused then
        return pause_position
    else
        return (os.clock() - start_time) * playback_speed
    end
end

local function play_realtime_events()
    if paused then return end
    local elapsed = get_current_playback_position()
    
    while next_event_index <= #events do
        local ev = events[next_event_index]
        local event_time = ev.abs_time
        if ev.type == "off" and random_note_enabled then
            local random_offset = (math.random(0,20) * 0.01)
            event_time = ev.abs_time - random_offset
            if event_time < 0 then
                event_time = 0
            end
        end
        if ev.type == "on" and random_note_enabled then
            local random_offset = math.random(0, 10) * 0.01
            event_time = ev.abs_time - random_offset
            if event_time < 0 then
                event_time = 0
            end
        end
        if event_time <= elapsed then
            if ev.type == "on" then
                local k = key_map[ev.note]
                if k then
                    if k.ctrl and not ctrl then vim:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game); ctrl = true elseif not k.ctrl and ctrl then vim:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game); ctrl = false end
                    if k.shift and not shift then vim:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game); shift = true elseif not k.shift and shift then vim:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game); shift = false end
                    vim:SendKeyEvent(true, k.keycode, false, game)
                    active_notes[ev.note] = k

                    if no_note_off_enabled then
                        vim:SendKeyEvent(false, k.keycode, false, game)
                        active_notes[ev.note] = nil
                    end
                end
            elseif ev.type == "off" then
                if not no_note_off_enabled then
                    local k = active_notes[ev.note]
                    if k then
                        vim:SendKeyEvent(false, k.keycode, false, game)
                        active_notes[ev.note] = nil
                    end
                end
            elseif ev.type == "control" then
                local s = ev.vel >= 64
                if auto_sustain_enabled then
                    if not sustain then 
                        vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        sustain = true 
                    end
                else
                    if s ~= sustain then 
                        vim:SendKeyEvent(s, Enum.KeyCode.Space, false, game)
                        sustain = s 
                    end
                end
            end
            next_event_index = next_event_index + 1
        else
            break
        end
    end

    if next_event_index > #events then
        start_time = 0
        pause_position = 0
        release_all_keys_except_spacebar()
    end
end

local function start_playback(parsed_events, tempo_changes)
    events = parsed_events
    tempo_events = tempo_changes or {}
    total_duration = events[#events] and events[#events].abs_time or 0
    start_time = os.clock()
    next_event_index = 1
    pause_position = 0
    release_all_keys_except_spacebar()
    paused = false
end

local function pause_playback()
    if not paused then
        paused = true
        pause_time = os.clock()
        pause_position = (os.clock() - start_time) * playback_speed
        release_all_keys_except_spacebar()
    end
end

local function resume_playback()
    if paused then
        start_time = os.clock() - (pause_position / playback_speed)
        paused = false
    end
end

local function stop_playback()
    paused = true
    start_time = 0
    next_event_index = 1
    pause_time = 0
    pause_position = 0
    release_all_keys_except_spacebar()
end

local function seek_to_position(ratio)
    local target_time = total_duration * ratio
    pause_position = target_time
    
    next_event_index = 1
    for i = 1, #events do
        if events[i].abs_time > target_time then
            next_event_index = i
            break
        end
    end
    
    if not paused then
        start_time = os.clock() - (target_time / playback_speed)
    end
    
    release_all_keys_except_spacebar()
end

local function disableAutoLocalize(obj)
    if obj:IsA("GuiObject") then
        obj.AutoLocalize = false
    end
    for _, child in ipairs(obj:GetChildren()) do
        disableAutoLocalize(child)
    end
end

local screen_gui = Instance.new("ScreenGui", GUIParent)
screen_gui.Name = "MIDIPLAYERPRO"
screen_gui.IgnoreGuiInset = true
screen_gui.ResetOnSpawn = false

local frame = Instance.new("Frame", screen_gui)
frame.Size = UDim2.new(0, 480, 0, 350)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true

local main_corner = Instance.new("UICorner", frame)
main_corner.CornerRadius = UDim.new(0, 16)

local title_bar = Instance.new("Frame", frame)
title_bar.Size = UDim2.new(1, 0, 0, 50)
title_bar.Position = UDim2.new(0, 0, 0, 0)
title_bar.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
title_bar.BorderSizePixel = 0
title_bar.BackgroundTransparency = 1

local title_corner = Instance.new("UICorner", title_bar)
title_corner.CornerRadius = UDim.new(0, 12)

local title_label = Instance.new("TextLabel", title_bar)
title_label.Size = UDim2.new(1, -80, 1, 0)
title_label.Position = UDim2.new(0.5, 0, 0.5, -18)
title_label.AnchorPoint = Vector2.new(0.5, 0)
title_label.Text = "MIDI Player Pro"
title_label.TextColor3 = Color3.fromRGB(255, 255, 255)
title_label.TextSize = 22
title_label.BackgroundTransparency = 1
title_label.Font = Enum.Font.Gotham
title_label.TextXAlignment = Enum.TextXAlignment.Left

local title_stroke = Instance.new("UIStroke", title_label)
title_stroke.Thickness = 1
title_stroke.Color = Color3.fromRGB(255, 255, 255)

local close_button = Instance.new("TextButton", title_bar)
close_button.Size = UDim2.new(0, 35, 0, 35)
close_button.Position = UDim2.new(1, -45, 0.5, -17.5)
close_button.Text = "×"
close_button.TextColor3 = Color3.fromRGB(139, 139, 146)
close_button.TextScaled = true
close_button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close_button.BackgroundTransparency = 1
close_button.Font = Enum.Font.Gotham

local close_corner = Instance.new("UICorner", close_button)
close_corner.CornerRadius = UDim.new(1, 0)

local close_stroke = Instance.new("UIStroke", close_button)
close_stroke.Thickness = 1
close_stroke.Color = Color3.fromRGB(139, 139, 146)

local filename_box = Instance.new("TextBox", frame)
filename_box.Size = UDim2.new(1, -130, 0, 40)
filename_box.Position = UDim2.new(0, 15, 0, 65)
filename_box.PlaceholderText = "Enter MIDI file name or URL"
filename_box.Text = ""
filename_box.TextScaled = false
filename_box.TextSize = 16
filename_box.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
filename_box.TextColor3 = Color3.fromRGB(255, 255, 255)
filename_box.Font = Enum.Font.Gotham
filename_box.ClearTextOnFocus = false

local filename_corner = Instance.new("UICorner", filename_box)
filename_corner.CornerRadius = UDim.new(0, 8)

local load_button = Instance.new("TextButton", frame)
load_button.Size = UDim2.new(0, 50, 0, 40)
load_button.Position = UDim2.new(1, -115, 0, 65)
load_button.Text = "Load"
load_button.TextScaled = false
load_button.TextSize = 16
load_button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
load_button.TextColor3 = Color3.fromRGB(255, 255, 255)
load_button.Font = Enum.Font.Gotham

local load_corner = Instance.new("UICorner", load_button)
load_corner.CornerRadius = UDim.new(0, 8)

local list_button = Instance.new("TextButton", frame)
list_button.Size = UDim2.new(0, 50, 0, 40)
list_button.Position = UDim2.new(1, -60, 0, 65)
list_button.Text = "List"
list_button.TextScaled = false
list_button.TextSize = 16
list_button.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
list_button.TextColor3 = Color3.fromRGB(255, 255, 255)
list_button.Font = Enum.Font.Gotham

local list_corner = Instance.new("UICorner", list_button)
list_corner.CornerRadius = UDim.new(0, 8)

local auto_sustain_button = Instance.new("TextButton", frame)
auto_sustain_button.Size = UDim2.new(0, 140, 0, 35)
auto_sustain_button.Position = UDim2.new(0, 15, 0, 115)
auto_sustain_button.Text = "🔄 Auto Sustain: ON"
auto_sustain_button.TextScaled = false
auto_sustain_button.TextSize = 14
auto_sustain_button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
auto_sustain_button.TextColor3 = Color3.fromRGB(255, 255, 255)
auto_sustain_button.Font = Enum.Font.Gotham

local auto_corner = Instance.new("UICorner", auto_sustain_button)
auto_corner.CornerRadius = UDim.new(0, 8)

local random_note_button = Instance.new("TextButton", frame)
random_note_button.Size = UDim2.new(0, 140, 0, 35)
random_note_button.Position = UDim2.new(0.5, 0, 0, 115)
random_note_button.AnchorPoint = Vector2.new(0.5, 0)
random_note_button.Text = "🎲 RandomNote: OFF"
random_note_button.TextScaled = false
random_note_button.TextSize = 14
random_note_button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
random_note_button.TextColor3 = Color3.fromRGB(255, 255, 255)
random_note_button.Font = Enum.Font.Gotham

local random_off_corner = Instance.new("UICorner", random_note_button)
random_off_corner.CornerRadius = UDim.new(0, 8)

local no_note_off_button = Instance.new("TextButton", frame)
no_note_off_button.Size = UDim2.new(0, 140, 0, 35)
no_note_off_button.Position = UDim2.new(1, -155, 0, 115)
no_note_off_button.Text = "🎹 NoNoteOff: OFF"
no_note_off_button.TextScaled = false
no_note_off_button.TextSize = 14
no_note_off_button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
no_note_off_button.TextColor3 = Color3.fromRGB(255, 255, 255)
no_note_off_button.Font = Enum.Font.Gotham

local no_note_off_corner = Instance.new("UICorner", no_note_off_button)
no_note_off_corner.CornerRadius = UDim.new(0, 8)

local file_list_frame = Instance.new("ScrollingFrame", frame)
file_list_frame.Size = UDim2.new(0, 160, 0, 200)
file_list_frame.Position = UDim2.new(0, -160, 0, 0)
file_list_frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
file_list_frame.BorderSizePixel = 0
file_list_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
file_list_frame.ScrollBarThickness = 12
file_list_frame.Visible = false

local file_corner = Instance.new("UICorner", file_list_frame)
file_corner.CornerRadius = UDim.new(0, 8)

local file_list_layout = Instance.new("UIListLayout", file_list_frame)
file_list_layout.SortOrder = Enum.SortOrder.LayoutOrder
file_list_layout.Padding = UDim.new(0, 5)

local button_container = Instance.new("Frame", frame)
button_container.Size = UDim2.new(1, -30, 0, 50)
button_container.Position = UDim2.new(0, 15, 0, 160)
button_container.BackgroundTransparency = 1

local button_layout = Instance.new("UIListLayout", button_container)
button_layout.FillDirection = Enum.FillDirection.Horizontal
button_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
button_layout.Padding = UDim.new(0, 10)

local play_button = Instance.new("TextButton", button_container)
play_button.Size = UDim2.new(0, 90, 0, 45)
play_button.Text = "Play"
play_button.TextScaled = false
play_button.TextSize = 16
play_button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
play_button.TextColor3 = Color3.fromRGB(255, 255, 255)
play_button.Font = Enum.Font.Gotham

local play_corner = Instance.new("UICorner", play_button)
play_corner.CornerRadius = UDim.new(0, 8)

local pause_button = Instance.new("TextButton", button_container)
pause_button.Size = UDim2.new(0, 90, 0, 45)
pause_button.Text = "Pause"
pause_button.TextScaled = false
pause_button.TextSize = 16
pause_button.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
pause_button.TextColor3 = Color3.fromRGB(255, 255, 255)
pause_button.Font = Enum.Font.Gotham

local pause_corner = Instance.new("UICorner", pause_button)
pause_corner.CornerRadius = UDim.new(0, 8)

local stop_button = Instance.new("TextButton", button_container)
stop_button.Size = UDim2.new(0, 90, 0, 45)
stop_button.Text = "Stop"
stop_button.TextScaled = false
stop_button.TextSize = 16
stop_button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
stop_button.TextColor3 = Color3.fromRGB(255, 255, 255)
stop_button.Font = Enum.Font.Gotham

local stop_corner = Instance.new("UICorner", stop_button)
stop_corner.CornerRadius = UDim.new(0, 8)

local slider_container = Instance.new("Frame", frame)
slider_container.Size = UDim2.new(1, -30, 0, 30)
slider_container.Position = UDim2.new(0, 15, 0, 220)
slider_container.BackgroundTransparency = 1

local slider_bg = Instance.new("Frame", slider_container)
slider_bg.Size = UDim2.new(1, 0, 0, 8)
slider_bg.Position = UDim2.new(0, 0, 0.5, -4)
slider_bg.BackgroundColor3 = Color3.fromRGB(30, 35, 45)

local slider_bg_corner = Instance.new("UICorner", slider_bg)
slider_bg_corner.CornerRadius = UDim.new(0, 4)

local slider = Instance.new("TextButton", slider_container)
slider.Size = UDim2.new(1, 0, 0, 8)
slider.Position = UDim2.new(0, 0, 0.5, -4)
slider.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
slider.Text = ""

local slider_corner = Instance.new("UICorner", slider)
slider_corner.CornerRadius = UDim.new(0, 4)

local handle = Instance.new("Frame", slider)
handle.Size = UDim2.new(0, 16, 0, 24)
handle.Position = UDim2.new(0, -8, 0.5, -12)
handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
handle.BorderSizePixel = 0

local handle_corner = Instance.new("UICorner", handle)
handle_corner.CornerRadius = UDim.new(1, 0)

local handle_stroke = Instance.new("UIStroke", handle)
handle_stroke.Thickness = 2
handle_stroke.Color = Color3.fromRGB(100, 150, 255)

local speed_container = Instance.new("Frame", frame)
speed_container.Size = UDim2.new(1, -30, 0, 30)
speed_container.Position = UDim2.new(0, 15, 0, 260)
speed_container.BackgroundTransparency = 1

local speed_label = Instance.new("TextLabel", speed_container)
speed_label.Size = UDim2.new(0, 100, 0, 20)
speed_label.Position = UDim2.new(0, 0, 0.5, -10)
speed_label.Text = "⚡ Speed: 1.00x"
speed_label.TextScaled = false
speed_label.TextSize = 14
speed_label.BackgroundTransparency = 1
speed_label.TextColor3 = Color3.fromRGB(255, 255, 255)
speed_label.Font = Enum.Font.Gotham
speed_label.TextXAlignment = Enum.TextXAlignment.Left

local speed_slider_bg = Instance.new("Frame", speed_container)
speed_slider_bg.Size = UDim2.new(1, -110, 0, 8)
speed_slider_bg.Position = UDim2.new(0, 110, 0.5, -4)
speed_slider_bg.BackgroundColor3 = Color3.fromRGB(30, 35, 45)

local speed_bg_corner = Instance.new("UICorner", speed_slider_bg)
speed_bg_corner.CornerRadius = UDim.new(0, 4)

local speed_slider = Instance.new("TextButton", speed_container)
speed_slider.Size = UDim2.new(1, -110, 0, 8)
speed_slider.Position = UDim2.new(0, 110, 0.5, -4)
speed_slider.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
speed_slider.Text = ""

local speed_slider_corner = Instance.new("UICorner", speed_slider)
speed_slider_corner.CornerRadius = UDim.new(0, 4)

local speed_handle = Instance.new("Frame", speed_slider)
speed_handle.Size = UDim2.new(0, 16, 0, 24)
speed_handle.Position = UDim2.new(0.33, -8, 0.5, -12)
speed_handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speed_handle.BorderSizePixel = 0

local speed_handle_corner = Instance.new("UICorner", speed_handle)
speed_handle_corner.CornerRadius = UDim.new(1, 0)

local speed_handle_stroke = Instance.new("UIStroke", speed_handle)
speed_handle_stroke.Thickness = 2
speed_handle_stroke.Color = Color3.fromRGB(150, 100, 255)

local time_label = Instance.new("TextLabel", frame)
time_label.Size = UDim2.new(1, -30, 0, 25)
time_label.Position = UDim2.new(0, 15, 0, 300)
time_label.Text = "⏱ Time: 0.00 / 0.00"
time_label.TextScaled = false
time_label.TextSize = 14
time_label.BackgroundTransparency = 1
time_label.TextColor3 = Color3.fromRGB(200, 200, 200)
time_label.Font = Enum.Font.Gotham
time_label.TextXAlignment = Enum.TextXAlignment.Center

local function update_time_label()
    local elapsed = get_current_playback_position()
    elapsed = math.max(0, elapsed)
    
    if total_duration > 0 then
        local ratio = math.clamp(elapsed / total_duration, 0, 1)
        handle.Position = UDim2.new(ratio, -8, 0.5, -12)
        time_label.Text = string.format("⏱ Time: %.2f / %.2f", elapsed, total_duration)
    else
        handle.Position = UDim2.new(0, -8, 0.5, -12)
        time_label.Text = string.format("⏱ Time: 0.00 / %.2f", total_duration)
    end
end

auto_sustain_button.MouseButton1Click:Connect(function()
    auto_sustain_enabled = not auto_sustain_enabled
    if auto_sustain_enabled then
        auto_sustain_button.Text = "🔄 Auto Sustain: OFF"
        auto_sustain_button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
        vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        sustain = false
        release_all_keys_except_spacebar()
    else
        auto_sustain_button.Text = "🔄 Auto Sustain: ON"
        auto_sustain_button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
        vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        sustain = true
    end
end)

random_note_button.MouseButton1Click:Connect(function()
    random_note_enabled = not random_note_enabled
    if random_note_enabled then
        random_note_button.Text = "🎲 RandomNote: ON"
        random_note_button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
        release_all_keys_except_spacebar()
    else
        random_note_button.Text = "🎲 RandomNote: OFF"
        random_note_button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
        release_all_keys_except_spacebar()
    end
end)

no_note_off_button.MouseButton1Click:Connect(function()
    no_note_off_enabled = not no_note_off_enabled
    if no_note_off_enabled then
        no_note_off_button.Text = "🎹 NoNoteOff: ON"
        no_note_off_button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
        release_all_keys_except_spacebar()
    else
        no_note_off_button.Text = "🎹 NoNoteOff: OFF"
        no_note_off_button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
        release_all_keys_except_spacebar()
    end
end)

close_button.MouseButton1Click:Connect(function()
    stop_playback()
    screen_gui:Destroy()
end)

close_button.MouseEnter:Connect(function()
    close_button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)
close_button.MouseLeave:Connect(function()
    close_button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end)

local dragging = false
slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and total_duration > 0 then
        dragging = true
        release_all_keys_except_spacebar()
        local x = input.Position.X - slider.AbsolutePosition.X
        local ratio = math.clamp(x / slider.AbsoluteSize.X, 0, 1)
        seek_to_position(ratio)
        handle.Position = UDim2.new(ratio, -8, 0.5, -12)
        update_time_label()
    end
end)
slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
slider.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement and total_duration > 0 then
        local x = input.Position.X - slider.AbsolutePosition.X
        local ratio = math.clamp(x / slider.AbsoluteSize.X, 0, 1)
        seek_to_position(ratio)
        handle.Position = UDim2.new(ratio, -8, 0.5, -12)
        update_time_label()
    end
end)

local speed_dragging = false
speed_slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        speed_dragging = true
        local was_playing = not paused
        if was_playing then
            pause_playback()
        end
        local x = input.Position.X - speed_slider.AbsolutePosition.X
        local ratio = math.clamp(x / speed_slider.AbsoluteSize.X, 0, 1)
        local old_speed = playback_speed
        playback_speed = 0.5 + (ratio * 1.5)
        speed_handle.Position = UDim2.new(ratio, -8, 0.5, -12)
        speed_label.Text = string.format("⚡ Speed: %.2fx", playback_speed)
        
        if not paused and start_time > 0 then
            local current_pos = get_current_playback_position()
            start_time = os.clock() - (current_pos / playback_speed)
        end
        if was_playing then
            resume_playback()
        end
    end
end)
speed_slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        speed_dragging = false
    end
end)
speed_slider.InputChanged:Connect(function(input)
    if speed_dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local was_playing = not paused
        if was_playing then
            pause_playback()
        end
        local x = input.Position.X - speed_slider.AbsolutePosition.X
        local ratio = math.clamp(x / speed_slider.AbsoluteSize.X, 0, 1)
        local old_speed = playback_speed
        playback_speed = 0.5 + (ratio * 1.5)
        speed_handle.Position = UDim2.new(ratio, -8, 0.5, -12)
        speed_label.Text = string.format("⚡ Speed: %.2fx", playback_speed)
        
        if not paused and start_time > 0 then
            local current_pos = get_current_playback_position()
            start_time = os.clock() - (current_pos / playback_speed)
        end
        if was_playing then
            resume_playback()
        end
    end
end)

run_service.RenderStepped:Connect(function()
    if not paused then
        play_realtime_events()
    end
    update_time_label()
end)

local function list_midi_files()
    midi_files = {}
    local success, files = pcall(listfiles, "./MIDI")
    if success then
        for _, file in ipairs(files) do
            if file:match("%.mid$") then
                table.insert(midi_files, file:match("[^/\\]+$"))
            end
        end
    end
end

local function populate_file_list()
    for _, child in ipairs(file_list_frame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    list_midi_files()
    file_list_frame.CanvasSize = UDim2.new(0, 0, 0, #midi_files * 40)
    for i, file in ipairs(midi_files) do
        local button = Instance.new("TextButton", file_list_frame)
        button.Size = UDim2.new(1, -10, 0, 35)
        button.Position = UDim2.new(0, 5, 0, (i-1)*40)
        button.Text = (#file > 17) and (file:sub(1, 17) .. "...") or file
        button.TextSize = 14
        button.TextScaled = false
        button.AutoLocalize = false
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        button.Font = Enum.Font.Gotham
        
        local file_button_corner = Instance.new("UICorner", button)
        file_button_corner.CornerRadius = UDim.new(0, 6)
        
        button.MouseButton1Click:Connect(function()
            filename_box.Text = file
            file_list_frame.Visible = false
        end)
    end
end

local function on_midi_data_received(data)
    if not data or #data < 14 or string.sub(data, 1, 4) ~= 'MThd' then
        filename_box.Text = "Invalid MIDI file"
        return
    end
    
    local parsed_events, tempo_changes = parse_midi_improved(data)
    if parsed_events and #parsed_events > 0 then 
        start_playback(parsed_events, tempo_changes) 
    else
        filename_box.Text = "Invalid MIDI file"
    end
end

load_button.MouseButton1Click:Connect(function()
    local ok, data = pcall(readfile, "./MIDI/" .. filename_box.Text)
    if ok then 
        on_midi_data_received(data) 
    else
        if string.match(filename_box.Text, "^https?://") then
            local success, result = pcall(function()
                return game:HttpGet(filename_box.Text)
            end)
            if success and result then
                on_midi_data_received(result)
            else
                filename_box.Text = "Invalid MIDI file"
            end
        else
            filename_box.Text = "File not found"
        end
    end
end)

play_button.MouseButton1Click:Connect(function()
    if paused then
        resume_playback()
    else
        if #events > 0 then
            start_playback(events, tempo_events)
        end
    end
end)

pause_button.MouseButton1Click:Connect(function()
    if paused then
        resume_playback()
    else
        pause_playback()
    end
end)

stop_button.MouseButton1Click:Connect(function()
    stop_playback()
    handle.Position = UDim2.new(0, -8, 0.5, -12)
    update_time_label()
end)

list_button.MouseButton1Click:Connect(function()
    file_list_frame.Visible = not file_list_frame.Visible
    if file_list_frame.Visible then
        populate_file_list()
    end
end)

uis.InputBegan:Connect(function(input, game_processed)
    if not game_processed and input.KeyCode == Enum.KeyCode.RightControl then
        screen_gui.Enabled = not screen_gui.Enabled
    end
end)

disableAutoLocalize(screen_gui)
