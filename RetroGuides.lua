--  RetroGuides - Online guide for retro games.
--  Copyright (C) 2025 - eadmaster
--  https://github.com/eadmaster/eadmaster/
-- 
--  RetroGuides is free software: you can redistribute it and/or modify it under the terms
--  of the GNU General Public License as published by the Free Software Found-
--  ation, either version 3 of the License, or (at your option) any later version.
--
--  RetroGuides is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--  PURPOSE.  See the GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along with RetroSubs.
--  If not, see <http://www.gnu.org/licenses/>.

-- Shows a guide ingame from a txt file or a markdown with multiple sections.
-- Controls: P1 Start+Select=Toggle guide ; d-pad up/down = scroll up/down
-- The txt file should match the content filename to be found.
-- e.g. "Bomberman (USA).nes" -> "Bomberman (USA).txt"


local global_guide_filename = "../vg.md"  -- must be a markdown file
local using_global_guide_file = true

local file = io.open(global_guide_filename, "r")
if not file then
    print("global guide file not found: " .. global_guide_filename)
    using_global_guide_file = false
    
    file = io.open(gameinfo.getromname() .. ".txt")
    if file == nil then
	-- try to load from content dir
	local curr_rom_path = nil
	
	if gameinfo and type(gameinfo.getrompath) == "function" then 
	    curr_rom_path = gameinfo.getrompath()  -- retroarch-only
	end
	
	local config = client.getconfig()    -- bizhawk-only
	if config.RecentRoms and config.RecentRoms[0] then
	    curr_rom_path = config.RecentRoms[0]
	    curr_rom_path = curr_rom_path:gsub("%*OpenRom%*", "")
	end
	
	if curr_rom_path then
	    curr_rom_path = curr_rom_path:gsub("%.[^%.]+$", ".txt") -- Replace the extension
	    file = io.open(curr_rom_path)
	end
	
	if file == nil then
	    print("file not found: " .. curr_rom_path)
	    -- TODO: if nothing found, show a menu to select a txt file to open
	    return
	end
    end
end


local lines = {}
for line in file:lines() do
    table.insert(lines, line)
end
file:close()

local found = false
local result = {}

-- Remove tags like "(...)" or "[...]" and trim spaces
local function clean_header(name)
    local cleaned = name:gsub("%b()", ""):gsub("%b[]", "")
    cleaned = cleaned:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1") -- trim
    return cleaned
end

local function lower(s)
    return string.lower(s)
end


-- Helper: word-wrap a long line into smaller lines
function wrap_line(line)
    local MAX_LINE_LENGTH = 45  -- max columns before wrapping
    local wrapped = {}
    while #line > MAX_LINE_LENGTH do
	local chunk = line:sub(1, MAX_LINE_LENGTH)
	local last_space = chunk:match(".*()[%s%-_/.,;:!?]") -- find last word boundary
	if last_space and last_space > 20 then
	    table.insert(wrapped, line:sub(1, last_space))
	    line = line:sub(last_space + 1):gsub("^%s*", "")
	else
	    table.insert(wrapped, chunk)
	    line = line:sub(MAX_LINE_LENGTH + 1)
	end
    end
    table.insert(wrapped, line)
    return wrapped
end


starting_line = 0  -- global to keep state after closing

function show_text(text_lines)
    local x_pos = 0
    local y_pos = 0
    local bg_color = "#DF000000" --0xEF000000  -- default: black (0xAARRGGBB)
    local fg_color = "#FFFFFFFF"  -- default: white
    local height_box = client.bufferheight()
    local width_box = client.bufferwidth()
    local font_size = 8
    --local font_size = 24
    --local font_size = client.getconfig().FontSize 
    --local font_face = "Arial" -- optional
    local TEXTBOX_PADDING = 2
    local LINE_SPACING = font_size
    local needs_redraw = true
        
    while true do

	if needs_redraw then
	    
	    needs_redraw = false
	    gui.drawRectangle(x_pos, y_pos, width_box, height_box, bg_color, bg_color)

	    -- Split text into lines using <br>
	    local line_count = 0
	    local curr_y_pos = y_pos + line_count * LINE_SPACING
	    
	    for i, raw_line in ipairs(text_lines) do
		if i >= starting_line then
		    for _, line in ipairs(wrap_line(raw_line)) do
			curr_y_pos = y_pos + line_count * LINE_SPACING
			gui.pixelText(x_pos + TEXTBOX_PADDING, curr_y_pos, line, fg_color, bg_color) --, fontfamily
			-- ALT. with scalable font:
			--gui.drawStringO(x_pos + TEXTBOX_PADDING, curr_y_pos, line, fg_color, bg_color, font_size)  --, [string fontfamily = nil], [string fontstyle = nil], [string horizalign = nil], [string vertalign = nil], [string surfacename = nil])
			line_count = line_count + 1
		    end
		    
		    --emu.pause()
		    --print(curr_y_pos)
		    --client.sleep(200)
		    --if line_count > 30 then
		    --    break
		    --end
		    if(curr_y_pos > client.bufferheight()) then
		    --if(curr_y_pos > client.screenheight()) then
			break
		    end
		end
	    end
	end
	
	--emu.frameadvance();
	--client.sleep(500) -- debounce
	--emu.pause()
	
	emu.frameadvance();
	
	--local pressed_keys = input.get()
	--if pressed_keys[GUIDE_HOTKEY] then
	if emu.framecount() % 10 == 0 then  -- debounce
	    local joy = joypad.get()
	    if(joy["P1 Start"]=="True" and joy["P1 Select"]=="True") then
		gui.cleartext()
		gui.clearGraphics()
		--emu.unpause()
		return
	    elseif (joy["P1 Down"]=="True") then
		gui.cleartext()
		gui.clearGraphics()
		starting_line = starting_line + 1
		needs_redraw = true
	    elseif (joy["P1 Up"]=="True") then
		gui.cleartext()
		gui.clearGraphics()
		starting_line = starting_line - 1
		if(starting_line)<0 then
		    starting_line = 0
		end
		needs_redraw = true
	    end
	end
    end  -- while
end


function find_text(target_header)
    for i, line in ipairs(lines) do
	local header = line:match("^##%s*(.+)")
	if header then
	    if found then
		break -- reached next header, stop collecting
	    end
	    -- substring, case-insensitive match
	    if header:find(target_header, 1, true) then
		found = true
	    end
	elseif found then
	    --if line:lower():match("^sources:") then
	--	break
	--    end
	    table.insert(result, line)
	end
    end

    if #result == 0 then
	print("Header not found or section is empty.")
	return false
    else
	print(table.concat(result, "\n"))
	show_text(result)
	--gui.addmessage("guide found, press Select+Start to see it")
	return true
    end
end


if using_global_guide_file then
    -- look and extract the subsection
    local target_header = clean_header(gameinfo.getromname())

    if not find_text(target_header) then
	--gui.addmessage("guide not found: " .. target_header)
	local curr_rom_path = ""
	
	if gameinfo and type(gameinfo.getrompath) == "function" then 
	    curr_rom_path = gameinfo.getrompath()  -- retroarch-only
	end
	
	local config = client.getconfig()    -- bizhawk-only
	if config.RecentRoms and config.RecentRoms[0] then
	    curr_rom_path = config.RecentRoms[0]
	    curr_rom_path = curr_rom_path:gsub("%*OpenRom%*", "")
	end
	
	if curr_rom_path then
	    curr_rom_path = curr_rom_path:gsub("%.[^%.]+$", "") -- Replace the extension
	    target_header = clean_header(curr_rom_path)
	end
	
	if not find_text(target_header) then
	    print("guide not found: " .. target_header)
	    gui.addmessage("guide not found: " .. target_header)
	    return
	end
    end
else
    -- just insert all the lines
    for _, line in ipairs(lines) do
	table.insert(result, line)
    end
    show_text(result)
    --gui.addmessage("guide found, press Select+Start to see it")
end



while true do
    
    if emu.framecount() % 10 == 0 then  -- debounce
	local joy = joypad.get()
	if(joy["P1 Start"]=="True" and joy["P1 Select"]=="True") then
	    --print("guide")
	    show_text(result)
	end
    end
    
    emu.frameadvance();
end  -- while

