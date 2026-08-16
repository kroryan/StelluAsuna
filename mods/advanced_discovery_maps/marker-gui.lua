-- Marker GUI for Persistent Map Mod
-- Provides a list interface for managing markers with delete and teleport functionality

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

-- Store active waypoint HUDs for players
local active_waypoints = {}

-- GUI configuration
local marker_gui = {
	formspec_version = 6,
	window_width = 25,   -- CORRECCIÓN: Ampliado de 21 a 25 para dar espacio al texto
	window_height = 12,
	padding = 0.5,
	button_height = 0.8,
	button_width = 2.4,  -- CORRECCIÓN: Reducido de 3 a 2.4 para compactar los botones
	list_item_height = 1.2,
	scroll_height = 8,
	header_height = 1.5,
	footer_height = 2,
}

-- Get marker list for a player
local function get_player_markers_list(player_name)
	local player_data_entry = persistent_map.get_player_data(player_name)
	if not player_data_entry then
		return {}
	end
	
	local markers = player_data_entry.markers
	local marker_list = {}
	
	for marker_id, marker in pairs(markers) do
		table.insert(marker_list, {
			id = marker_id,
			name = marker.name or "Unnamed",
			x = marker.x,
			y = marker.y,
			z = marker.z,
			color_index = marker.color_index,
			timestamp = marker.timestamp
		})
	end
	
	-- Sort by timestamp (newest first)
	table.sort(marker_list, function(a, b)
		return (a.timestamp or 0) > (b.timestamp or 0)
	end)
	
	return marker_list
end

-- Add waypoint HUD for a marker
local function addWaypointHud(player, marker)
	local player_name = player:get_player_name()
	local wayName = marker.name or "Unnamed"
	local wayPos = vector.new(marker.x, marker.y, marker.z)
	
	-- Remove existing waypoint if any
	if active_waypoints[player_name] then
		player:hud_remove(active_waypoints[player_name].hudId)
		active_waypoints[player_name] = nil
	end
	
	-- Add new waypoint HUD
	local hudId = player:hud_add({
		hud_elem_type = "waypoint",
		name = wayName,
		text = "m",
		number = 0xFFFFFF,
		world_pos = wayPos,
	})
	
	-- Store waypoint info
	active_waypoints[player_name] = {
		hudId = hudId,
		marker_id = marker.id,
		name = wayName
	}
	
	return hudId
end

-- Remove waypoint HUD for a player
local function removeWaypointHud(player)
	local player_name = player:get_player_name()
	if active_waypoints[player_name] then
		player:hud_remove(active_waypoints[player_name].hudId)
		active_waypoints[player_name] = nil
		return true
	end
	return false
end

-- Check if player has an active waypoint for a specific marker
local function hasWaypointForMarker(player_name, marker_id)
	return active_waypoints[player_name] and active_waypoints[player_name].marker_id == marker_id
end

-- Check if player has teleport permission
local function can_teleport(player_name)
	local player = minetest.get_player_by_name(player_name)
	if not player then return false end
	
	-- Check for teleport privilege or if player is admin
	return minetest.check_player_privs(player_name, {teleport = true}) or 
	       minetest.check_player_privs(player_name, {server = true})
end

-- Show marker management GUI
function persistent_map.show_marker_gui(player_name)
	local player = minetest.get_player_by_name(player_name)
	if not player then return end
	
	local markers = get_player_markers_list(player_name)
	local can_tp = can_teleport(player_name)
	
	-- Calculate content height based on number of markers
	local content_height = math.max(marker_gui.scroll_height, #markers * marker_gui.list_item_height)
	
	local formspec = {}
	formspec[1] = string.format("formspec_version[%d]", marker_gui.formspec_version)
	formspec[2] = string.format("size[%.2f,%.2f]", marker_gui.window_width, marker_gui.window_height)
	formspec[3] = "bgcolor[#00000080;true]"
	
	-- Header
	local header_y = marker_gui.padding
	formspec[4] = string.format("label[%.2f,%.2f;%s]", 
		marker_gui.window_width / 2 - 3, header_y, S("Marker Management"))
	formspec[5] = string.format("label[%.2f,%.2f;%s]", 
		marker_gui.padding, header_y + 0.5, S("Total Markers: @1", #markers))

	-- Scrollable container for marker list
	local scroll_y = header_y + marker_gui.header_height
	formspec[6] = string.format(
		"scroll_container[%.2f,%.2f;%.2f,%.2f;marker_list;vertical;0.1]",
		marker_gui.padding, scroll_y, 
		marker_gui.window_width - marker_gui.padding * 2, 
		marker_gui.scroll_height
	)
	
	local formspec_index = 7
	
	-- List markers
	if #markers == 0 then
		formspec[formspec_index] = string.format(
			"label[%.2f,%.2f;%s]",
			1, 1, S("No markers found. Create markers using the map interface (/map)")
		)
		formspec_index = formspec_index + 1
	else
		for i, marker in ipairs(markers) do
			local y_pos = (i - 1) * marker_gui.list_item_height
			local color = persistent_map.marker_colors[marker.color_index] or persistent_map.marker_colors[1]
			
			-- Marker color indicator
			formspec[formspec_index] = string.format(
				"box[%.2f,%.2f;%.2f,%.2f;%s]",
				0.2, y_pos + 0.1, 0.6, 0.6, color.color
			)
			formspec_index = formspec_index + 1
			
			-- Marker information
			local coords_text = string.format("(%d, %d, %d)", 
				math.floor(marker.x), math.floor(marker.y), math.floor(marker.z))
			local distance = ""
			
			-- Calculate distance from player
			local player_pos = player:get_pos()
			if player_pos then
				local marker_pos = vector.new(marker.x, marker.y, marker.z)
				local dist = vector.distance(player_pos, marker_pos)
				distance = string.format(" - %.1fm %s", dist, S("away"))
			end
			
			formspec[formspec_index] = string.format(
				"label[%.2f,%.2f;%s]",
				1, y_pos + 0.1, minetest.formspec_escape(marker.name)
			)
			formspec_index = formspec_index + 1
			
			formspec[formspec_index] = string.format(
				"label[%.2f,%.2f;%s%s]",
				1, y_pos + 0.4, coords_text, distance
			)
			formspec_index = formspec_index + 1
			
			-- Action buttons
			local has_waypoint = hasWaypointForMarker(player_name, marker.id)
			local button_count = can_tp and 5 or 4  -- 5 buttons if teleport available, 4 otherwise
			local buttons_start_x = marker_gui.window_width - marker_gui.padding * 2 - marker_gui.button_width * button_count - 0.8
			
			-- Edit Name button
			formspec[formspec_index] = string.format(
				"button[%.2f,%.2f;%.2f,%.2f;edit_name_%s;%s]",
				buttons_start_x,
				y_pos + 0.1, marker_gui.button_width, marker_gui.button_height,
				marker.id, S("Edit Name")
			)
			formspec_index = formspec_index + 1
			
			-- Edit Color button
			formspec[formspec_index] = string.format(
				"button[%.2f,%.2f;%.2f,%.2f;edit_color_%s;%s]",
				buttons_start_x + marker_gui.button_width + 0.1,
				y_pos + 0.1, marker_gui.button_width, marker_gui.button_height,
				marker.id, S("Edit Color")
			)
			formspec_index = formspec_index + 1
			
			-- Waypoint button
			local waypoint_button_text = has_waypoint and S("Remove Waypoint") or S("Show Waypoint")
			local waypoint_action = has_waypoint and "remove_waypoint_" or "show_waypoint_"
			formspec[formspec_index] = string.format(
				"button[%.2f,%.2f;%.2f,%.2f;%s%s;%s]",
				buttons_start_x + marker_gui.button_width * 2 + 0.2,
				y_pos + 0.1, marker_gui.button_width, marker_gui.button_height,
				waypoint_action, marker.id, waypoint_button_text
			)
			formspec_index = formspec_index + 1
			
			-- Delete button
			formspec[formspec_index] = string.format(
				"button[%.2f,%.2f;%.2f,%.2f;delete_%s;%s]",
				buttons_start_x + marker_gui.button_width * 3 + 0.3,
				y_pos + 0.1, marker_gui.button_width, marker_gui.button_height,
				marker.id, S("Delete")
			)
			formspec_index = formspec_index + 1
			
			-- Teleport button (only if player has permission)
			if can_tp then
				formspec[formspec_index] = string.format(
					"button[%.2f,%.2f;%.2f,%.2f;teleport_%s;%s]",
					buttons_start_x + marker_gui.button_width * 4 + 0.4,
					y_pos + 0.1, marker_gui.button_width, marker_gui.button_height,
					marker.id, S("Teleport")
				)
				formspec_index = formspec_index + 1
			end
			
			-- Separator line
			if i < #markers then
				formspec[formspec_index] = string.format(
					"box[%.2f,%.2f;%.2f,%.2f;#404040]",
					0, y_pos + marker_gui.list_item_height - 0.1, 
					marker_gui.window_width - marker_gui.padding * 2, 0.05
				)
				formspec_index = formspec_index + 1
			end
		end
	end
	
	-- Close scroll container
	formspec[formspec_index] = "scroll_container_end[]"
	formspec_index = formspec_index + 1
	
	-- Add marker section
	local add_marker_y = marker_gui.window_height - marker_gui.footer_height - 2.5
	
	-- Add marker label
	formspec[formspec_index] = string.format(
		"label[%.2f,%.2f;%s]",
		marker_gui.padding, add_marker_y, S("Add Marker by Coordinates:")
	)
	formspec_index = formspec_index + 1
	
	-- Coordinate input fields
	local field_width = 2.5
	local field_spacing = 0.2
	local fields_start_x = marker_gui.padding
	
	-- X coordinate field
	formspec[formspec_index] = string.format(
		"field[%.2f,%.2f;%.2f,%.2f;coord_x;;]",
		fields_start_x, add_marker_y + 0.4, field_width, 0.8
	)
	formspec_index = formspec_index + 1
	
	formspec[formspec_index] = string.format(
		"label[%.2f,%.2f;%s]",
		fields_start_x, add_marker_y + 0.2, S("X:")
	)
	formspec_index = formspec_index + 1
	
	-- Y coordinate field
	local y_field_x = fields_start_x + field_width + field_spacing
	formspec[formspec_index] = string.format(
		"field[%.2f,%.2f;%.2f,%.2f;coord_y;;]",
		y_field_x, add_marker_y + 0.4, field_width, 0.8
	)
	formspec_index = formspec_index + 1
	
	formspec[formspec_index] = string.format(
		"label[%.2f,%.2f;%s]",
		y_field_x, add_marker_y + 0.2, S("Y:")
	)
	formspec_index = formspec_index + 1
	
	-- Z coordinate field
	local z_field_x = y_field_x + field_width + field_spacing
	formspec[formspec_index] = string.format(
		"field[%.2f,%.2f;%.2f,%.2f;coord_z;;]",
		z_field_x, add_marker_y + 0.4, field_width, 0.8
	)
	formspec_index = formspec_index + 1
	
	formspec[formspec_index] = string.format(
		"label[%.2f,%.2f;%s]",
		z_field_x, add_marker_y + 0.2, S("Z:")
	)
	formspec_index = formspec_index + 1
	
	-- Marker name field
	local name_field_x = z_field_x + field_width + field_spacing
	formspec[formspec_index] = string.format(
		"field[%.2f,%.2f;%.2f,%.2f;marker_name;;]",
		name_field_x, add_marker_y + 0.4, field_width, 0.8
	)
	formspec_index = formspec_index + 1
	
	formspec[formspec_index] = string.format(
		"label[%.2f,%.2f;%s]",
		name_field_x, add_marker_y + 0.2, S("Name:")
	)
	formspec_index = formspec_index + 1
	
	-- Add marker button
	local add_button_x = name_field_x + field_width + field_spacing
	formspec[formspec_index] = string.format(
		"button[%.2f,%.2f;%.2f,%.2f;add_marker;%s]",
		add_button_x, add_marker_y + 0.4, marker_gui.button_width, marker_gui.button_height, S("Add Marker")
	)
	formspec_index = formspec_index + 1
	
	-- Footer buttons
	local footer_y = marker_gui.window_height - marker_gui.footer_height
	
	-- Close button
	formspec[formspec_index] = string.format(
		"button[%.2f,%.2f;%.2f,%.2f;close;%s]",
		marker_gui.padding, footer_y,
		marker_gui.button_width, marker_gui.button_height, S("Close")
	)
	formspec_index = formspec_index + 1
	
	-- Open map button
	formspec[formspec_index] = string.format(
		"button[%.2f,%.2f;%.2f,%.2f;open_map;%s]",
		marker_gui.padding + marker_gui.button_width + 0.2, footer_y,
		marker_gui.button_width, marker_gui.button_height, S("Open Map")
	)
	formspec_index = formspec_index + 1
	
	-- Delete all button
	if #markers > 0 then
		formspec[formspec_index] = string.format(
			"button[%.2f,%.2f;%.2f,%.2f;delete_all_confirm;%s]",
			marker_gui.window_width - marker_gui.padding - marker_gui.button_width, footer_y,
			marker_gui.button_width, marker_gui.button_height, S("Delete All")
		)
		formspec_index = formspec_index + 1
	end
	
	-- Permission info
	if not can_tp then
		formspec[formspec_index] = string.format(
			"label[%.2f,%.2f;%s]",
			marker_gui.padding, footer_y + marker_gui.button_height + 0.2, S("Note: You need 'teleport' privilege to use teleport buttons")
		)
		formspec_index = formspec_index + 1
	end
	
	minetest.show_formspec(player_name, "persistent_map:marker_gui", table.concat(formspec))
end

-- Show color selection dialog for a marker
local function show_color_selection_dialog(player_name, marker_id)
	local player = minetest.get_player_by_name(player_name)
	if not player then return end
	
	local player_data_entry = persistent_map.get_player_data(player_name)
	if not player_data_entry or not player_data_entry.markers[marker_id] then
		minetest.chat_send_player(player_name, S("Error: Marker not found"))
		return
	end
	
	local marker = player_data_entry.markers[marker_id]
	local current_color_index = marker.color_index or 1
	
	-- Create color selection formspec
	local formspec = {}
	formspec[1] = string.format("formspec_version[%d]", marker_gui.formspec_version)
	formspec[2] = "size[8,6]"
	formspec[3] = "bgcolor[#00000080;true]"
	
	-- Header
	formspec[4] = string.format("label[4,0.5;%s]",
		S("Select Color for '@1'", minetest.formspec_escape(marker.name or "Unnamed")))
	
	-- Color buttons in a 4x2 grid
	local colors_per_row = 4
	local button_size = 1.5
	local button_spacing = 0.2
	local start_x = 1
	local start_y = 1.5
	
	local formspec_index = 5
	
	for i, color_info in ipairs(persistent_map.marker_colors) do
		local row = math.floor((i - 1) / colors_per_row)
		local col = (i - 1) % colors_per_row
		local btn_x = start_x + col * (button_size + button_spacing)
		local btn_y = start_y + row * (button_size + button_spacing)
		
		-- Add colored background
		formspec[formspec_index] = string.format(
			"box[%.2f,%.2f;%.2f,%.2f;%s]",
			btn_x, btn_y, button_size, button_size, color_info.color
		)
		formspec_index = formspec_index + 1
		
		-- Add selection indicator for current color
		if i == current_color_index then
			formspec[formspec_index] = string.format(
				"box[%.2f,%.2f;%.2f,%.2f;#FFFFFF40]",
				btn_x - 0.1, btn_y - 0.1, button_size + 0.2, button_size + 0.2
			)
			formspec_index = formspec_index + 1
		end
		
		-- Color selection button
		formspec[formspec_index] = string.format(
			"button[%.2f,%.2f;%.2f,%.2f;select_color_%d_%s;%s]",
			btn_x, btn_y, button_size, button_size, i, marker_id, S(color_info.name)
		)
		formspec_index = formspec_index + 1
	end
	
	-- Cancel button
	formspec[formspec_index] = string.format(
		"button[2,4.5;2,0.8;cancel_color_edit;%s]", S("Cancel")
	)
	formspec_index = formspec_index + 1
	
	minetest.show_formspec(player_name, "persistent_map:color_selection", table.concat(formspec))
end

-- Show name editing dialog for a marker
local function show_name_edit_dialog(player_name, marker_id)
	local player = minetest.get_player_by_name(player_name)
	if not player then return end
	
	local player_data_entry = persistent_map.get_player_data(player_name)
	if not player_data_entry or not player_data_entry.markers[marker_id] then
		minetest.chat_send_player(player_name, S("Error: Marker not found"))
		return
	end
	
	local marker = player_data_entry.markers[marker_id]
	local current_name = marker.name or "Unnamed"
	
	-- Create name editing formspec
	local formspec = {}
	formspec[1] = string.format("formspec_version[%d]", marker_gui.formspec_version)
	formspec[2] = "size[8,4]"
	formspec[3] = "bgcolor[#00000080;true]"
	
	-- Header
	formspec[4] = string.format("label[4,0.5;%s]", S("Edit Marker Name"))
	
	-- Current name label
	formspec[5] = string.format("label[1,1.2;%s]",
		S("Current name: @1", minetest.formspec_escape(current_name)))
	
	-- Name input field
	formspec[6] = string.format("field[1,1.8;6,0.8;new_marker_name;%s;%s]",
		S("New name:"), minetest.formspec_escape(current_name))
	
	-- Store marker ID for the handler
	formspec[7] = string.format("field[0,0;0,0;marker_id_hidden;;%s]", marker_id)
	
	-- Buttons
	formspec[8] = string.format("button[1,2.8;2,0.8;save_name;%s]", S("Save"))
	formspec[9] = string.format("button[4,2.8;2,0.8;cancel_name_edit;%s]", S("Cancel"))
	
	minetest.show_formspec(player_name, "persistent_map:name_edit", table.concat(formspec))
end

-- Handle marker GUI input
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "persistent_map:marker_gui" then return end
	
	local player_name = player:get_player_name()
	
	-- Close button
	if fields.close or fields.quit then
        -- CORRECCIÓN: Orden explícita al motor C++ para destruir el formspec
        minetest.close_formspec(player_name, "persistent_map:marker_gui")
		return
	end
	
	-- Open map button
	if fields.open_map then
		-- Reset view offset when opening map
		persistent_map.set_map_view_offset(player_name, {x = 0, z = 0})
		-- Initialize zoom level if not set
		if not persistent_map.get_map_zoom_level(player_name) then
			persistent_map.set_map_zoom_level(player_name, persistent_map.default_zoom_index)
		end
		persistent_map.show_map(player_name)
		return
	end
	
	-- Delete all confirmation
	if fields.delete_all_confirm then
		local success, message = persistent_map.delete_all_markers_for_player(player_name)
		minetest.chat_send_player(player_name, message)
		if success then
			persistent_map.show_marker_gui(player_name) -- Refresh the GUI
		end
		return
	end
	
	-- Add marker by coordinates
	if fields.add_marker then
		local x_str = fields.coord_x or ""
		local y_str = fields.coord_y or ""
		local z_str = fields.coord_z or ""
		local name_str = fields.marker_name or ""
		
		-- Validate coordinates
		local x = tonumber(x_str)
		local y = tonumber(y_str)
		local z = tonumber(z_str)
		
		if not x or not y or not z then
			minetest.chat_send_player(player_name, S("Error: Please enter valid numeric coordinates for X, Y, and Z"))
			return
		end
		
		-- Use default name if none provided
		if name_str == "" then
			name_str = S("Marker at @1,@2,@3", math.floor(x), math.floor(y), math.floor(z))
		end
		
		-- Create the marker
		local marker_pos = {x = x, y = y, z = z}
		local success, message = persistent_map.add_marker_for_player(player_name, marker_pos, name_str)
		
		minetest.chat_send_player(player_name, message)
		
		if success then
			-- Refresh the GUI to show the new marker
			persistent_map.show_marker_gui(player_name)
		end
		return
	end
	
	-- Check for individual marker actions
	for field_name, _ in pairs(fields) do
		-- Delete marker
		local delete_match = field_name:match("^delete_(.+)$")
		if delete_match then
			local marker_id = delete_match
			local player_data_entry = persistent_map.get_player_data(player_name)
			if player_data_entry and player_data_entry.markers[marker_id] then
				local marker = player_data_entry.markers[marker_id]
				player_data_entry.markers[marker_id] = nil
				persistent_map.save_markers_for_player(player_name, player_data_entry.markers)
				minetest.chat_send_player(player_name,
					S("Deleted marker '@1'", marker.name or "Unnamed"))
				persistent_map.show_marker_gui(player_name) -- Refresh the GUI
			end
			return
		end
		
		-- Teleport to marker
		local teleport_match = field_name:match("^teleport_(.+)$")
		if teleport_match then
			local marker_id = teleport_match
			
			-- Check permission
			if not can_teleport(player_name) then
				minetest.chat_send_player(player_name,
					S("You don't have permission to teleport. Need 'teleport' privilege."))
				return
			end
			
			local player_data_entry = persistent_map.get_player_data(player_name)
			if player_data_entry and player_data_entry.markers[marker_id] then
				local marker = player_data_entry.markers[marker_id]
				local pos = vector.new(marker.x, marker.y + 1, marker.z) -- +1 to avoid spawning in ground
				
				-- Check if position is safe (not in solid blocks)
				local node_at = minetest.get_node(pos)
				local node_above = minetest.get_node(vector.add(pos, {x=0, y=1, z=0}))
				
				-- If position is not safe, try to find a safe spot nearby
				if node_at.name ~= "air" or node_above.name ~= "air" then
					-- Try to find air space above the marker
					for y_offset = 2, 10 do
						local test_pos = vector.new(marker.x, marker.y + y_offset, marker.z)
						local test_node = minetest.get_node(test_pos)
						local test_above = minetest.get_node(vector.add(test_pos, {x=0, y=1, z=0}))
						
						if test_node.name == "air" and test_above.name == "air" then
							pos = test_pos
							break
						end
					end
				end
				
				player:set_pos(pos)
				minetest.chat_send_player(player_name, 
					S("Teleported to marker '@1' at @2, @3, @4", 
						marker.name or "Unnamed", 
						math.floor(marker.x), math.floor(marker.y), math.floor(marker.z)))
				
				-- Close the GUI after teleporting
				minetest.close_formspec(player_name, "persistent_map:marker_gui")
			end
			return
		end
		
		-- Edit color for marker
		local edit_color_match = field_name:match("^edit_color_(.+)$")
		if edit_color_match then
			local marker_id = edit_color_match
			show_color_selection_dialog(player_name, marker_id)
			return
		end
		
		-- Edit name for marker
		local edit_name_match = field_name:match("^edit_name_(.+)$")
		if edit_name_match then
			local marker_id = edit_name_match
			show_name_edit_dialog(player_name, marker_id)
			return
		end
		
		-- Show waypoint for marker
		local show_waypoint_match = field_name:match("^show_waypoint_(.+)$")
		if show_waypoint_match then
			local marker_id = show_waypoint_match
			local player_data_entry = persistent_map.get_player_data(player_name)
			if player_data_entry and player_data_entry.markers[marker_id] then
				local marker = player_data_entry.markers[marker_id]
				marker.id = marker_id  -- Ensure marker has ID for waypoint tracking
				addWaypointHud(player, marker)
				minetest.chat_send_player(player_name,
					S("Waypoint set for marker '@1'", marker.name or "Unnamed"))
				persistent_map.show_marker_gui(player_name) -- Refresh the GUI
			end
			return
		end
		
		-- Remove waypoint for marker
		local remove_waypoint_match = field_name:match("^remove_waypoint_(.+)$")
		if remove_waypoint_match then
			local marker_id = remove_waypoint_match
			if removeWaypointHud(player) then
				minetest.chat_send_player(player_name, S("Waypoint removed"))
			else
				minetest.chat_send_player(player_name, S("No active waypoint found"))
			end
			persistent_map.show_marker_gui(player_name) -- Refresh the GUI
			return
		end
	end
end)

-- Handle name editing dialog input
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "persistent_map:name_edit" then return end
	
	local player_name = player:get_player_name()
	
	-- Cancel button
	if fields.cancel_name_edit or fields.quit then
		persistent_map.show_marker_gui(player_name) -- Return to marker GUI
		return
	end
	
	-- Save button
	if fields.save_name then
		local new_name = fields.new_marker_name or ""
		local marker_id = fields.marker_id_hidden or ""
		
		-- Validate input
		if marker_id == "" then
			minetest.chat_send_player(player_name, S("Error: Invalid marker ID"))
			persistent_map.show_marker_gui(player_name)
			return
		end
		
		-- Trim whitespace and validate name
		new_name = string.gsub(new_name, "^%s*(.-)%s*$", "%1")
		if new_name == "" then
			minetest.chat_send_player(player_name, S("Error: Marker name cannot be empty"))
			return
		end
		
		-- Update marker name
		local player_data_entry = persistent_map.get_player_data(player_name)
		if player_data_entry and player_data_entry.markers[marker_id] then
			local marker = player_data_entry.markers[marker_id]
			local old_name = marker.name or "Unnamed"
			
			marker.name = new_name
			persistent_map.save_markers_for_player(player_name, player_data_entry.markers)
			
			minetest.chat_send_player(player_name,
				S("Renamed marker from '@1' to '@2'", old_name, new_name))
			
			-- Return to marker GUI
			persistent_map.show_marker_gui(player_name)
		else
			minetest.chat_send_player(player_name, S("Error: Marker not found"))
			persistent_map.show_marker_gui(player_name)
		end
		return
	end
end)

-- Handle color selection dialog input
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "persistent_map:color_selection" then return end
	
	local player_name = player:get_player_name()
	
	-- Cancel button
	if fields.cancel_color_edit or fields.quit then
		persistent_map.show_marker_gui(player_name) -- Return to marker GUI
		return
	end
	
	-- Check for color selection
	for field_name, _ in pairs(fields) do
		local color_match = field_name:match("^select_color_(%d+)_(.+)$")
		if color_match then
			local color_index = tonumber(color_match)
			local marker_id = field_name:match("^select_color_%d+_(.+)$")
			
			if color_index and marker_id then
				local player_data_entry = persistent_map.get_player_data(player_name)
				if player_data_entry and player_data_entry.markers[marker_id] then
					local marker = player_data_entry.markers[marker_id]
					local old_color = persistent_map.marker_colors[marker.color_index] or persistent_map.marker_colors[1]
					local new_color = persistent_map.marker_colors[color_index] or persistent_map.marker_colors[1]
					
					-- Update marker color
					marker.color_index = color_index
					persistent_map.save_markers_for_player(player_name, player_data_entry.markers)
					
					minetest.chat_send_player(player_name,
						S("Changed color of marker '@1' from @2 to @3",
							marker.name or "Unnamed", S(old_color.name), S(new_color.name)))
					
					-- Return to marker GUI
					persistent_map.show_marker_gui(player_name)
				end
			end
			return
		end
	end
end)

-- Register chat command to open marker GUI
minetest.register_chatcommand("markers", {
	description = S("Open the marker management interface"),
	func = function(name)
		persistent_map.show_marker_gui(name)
		return true, S("Marker GUI opened")
	end,
})

-- Also register as /marker for convenience
minetest.register_chatcommand("marker", {
	description = S("Open the marker management interface"),
	func = function(name)
		persistent_map.show_marker_gui(name)
		return true, S("Marker GUI opened")
	end,
})

-- Clean up waypoints when player leaves
minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	if active_waypoints[player_name] then
		active_waypoints[player_name] = nil
	end
end)

minetest.log("action", "[persistent_map] Marker GUI loaded successfully")
