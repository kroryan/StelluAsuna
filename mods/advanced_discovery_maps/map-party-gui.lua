-- Map Party GUI System for Persistent Map Mod
-- Provides a graphical interface for managing map parties
-- Includes proper permission controls for admins and party leaders

local S = minetest.get_translator(minetest.get_current_modname())

-- GUI state storage for each player
local gui_state = {}

-- Helper function to check if player is server admin
local function is_server_admin(player_name)
    return minetest.check_player_privs(player_name, {server = true}) or 
           minetest.check_player_privs(player_name, {ban = true}) or
           minetest.check_player_privs(player_name, {kick = true})
end

-- Helper function to get party data from map-party.lua
local function get_map_parties()
    local storage = persistent_map.storage
    if not storage then
        return {}
    end
    
    local data = storage:get_string("map_parties")
    if data ~= "" then
        return minetest.deserialize(data) or {}
    end
    return {}
end

-- Helper function to get player's current party
local function get_player_party(player_name)
    local parties = get_map_parties()
    for party_name, party_data in pairs(parties) do
        for _, member in ipairs(party_data.members) do
            if member == player_name then
                return party_name, party_data
            end
        end
    end
    return nil, nil
end

-- Helper function to check if player is party owner
local function is_party_owner(player_name, party_name)
    local parties = get_map_parties()
    local party = parties[party_name]
    return party and party.owner == player_name
end

-- Helper function to save map parties
local function save_map_parties(parties)
    local storage = persistent_map.storage
    if storage then
        storage:set_string("map_parties", minetest.serialize(parties))
    end
end

-- Main party management GUI
function persistent_map.show_party_gui(player_name)
    local player = minetest.get_player_by_name(player_name)
    if not player then return end
    
    local is_admin = is_server_admin(player_name)
    local current_party_name, current_party_data = get_player_party(player_name)
    local is_owner = current_party_name and is_party_owner(player_name, current_party_name)
    local parties = get_map_parties()
    
    -- Initialize GUI state if not exists
    if not gui_state[player_name] then
        gui_state[player_name] = {
            view_mode = "main", -- main, create, manage, list
            selected_party = nil,
            scroll_pos = 0
        }
    end
    
    local state = gui_state[player_name]
    local formspec = {}
    
    -- Base formspec setup
    formspec[1] = "formspec_version[6]"
    formspec[2] = "size[16,12]"
    formspec[3] = "bgcolor[#00000080;true]"
    
    local formspec_index = 4
    
    if state.view_mode == "main" then
        -- Main menu view
        formspec[formspec_index] = "label[8,0.5;Map Party Management]"
        formspec_index = formspec_index + 1
        
        -- Current party status
        if current_party_name then
            formspec[formspec_index] = string.format("label[1,2;Current Party: %s]", current_party_name)
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = string.format("label[1,2.8;Members (%d): %s]", 
                #current_party_data.members, table.concat(current_party_data.members, ", "))
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = string.format("label[1,3.6;Owner: %s]", current_party_data.owner)
            formspec_index = formspec_index + 1
            
            if is_owner then
                formspec[formspec_index] = "label[1,4.4;You are the party owner]"
                formspec_index = formspec_index + 1
            end
        else
            formspec[formspec_index] = "label[1,2;You are not in any party]"
            formspec_index = formspec_index + 1
        end
        
        -- Action buttons
        local button_y = 6
        
        -- Create party button (always available)
        if not current_party_name then
            formspec[formspec_index] = string.format("button[1,%f;4,1;create_party;Create New Party]", button_y)
            formspec_index = formspec_index + 1
        end
        
        -- Manage current party button (owner only)
        if current_party_name and is_owner then
            formspec[formspec_index] = string.format("button[6,%f;4,1;manage_party;Manage Party]", button_y)
            formspec_index = formspec_index + 1
        end
        
        -- Leave party button (if in a party)
        if current_party_name then
            formspec[formspec_index] = string.format("button[11,%f;4,1;leave_party;Leave Party]", button_y)
            formspec_index = formspec_index + 1
        end
        
        -- List all parties button
        formspec[formspec_index] = string.format("button[1,%f;4,1;list_parties;List All Parties]", button_y + 1.5)
        formspec_index = formspec_index + 1
        
        -- Admin controls (admin only)
        if is_admin then
            formspec[formspec_index] = "label[1,9;Admin Controls:]"
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = "button[1,9.8;4,1;admin_manage;Manage All Parties]"
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = "button[6,9.8;4,1;admin_delete;Delete Any Party]"
            formspec_index = formspec_index + 1
        end
        
    elseif state.view_mode == "create" then
        -- Create party view
        formspec[formspec_index] = "label[8,0.5;Create New Party]"
        formspec_index = formspec_index + 1
        
        formspec[formspec_index] = "label[1,2;Party Name:]"
        formspec_index = formspec_index + 1
        
        formspec[formspec_index] = "field[1,2.8;8,1;party_name;;]"
        formspec_index = formspec_index + 1
        
        formspec[formspec_index] = "label[1,4;Initial Members (optional, one per line):]"
        formspec_index = formspec_index + 1
        
        formspec[formspec_index] = "textarea[1,4.8;8,4;initial_members;;]"
        formspec_index = formspec_index + 1
        
        formspec[formspec_index] = "button[1,9.5;3,1;create_confirm;Create Party]"
        formspec_index = formspec_index + 1
        
        formspec[formspec_index] = "button[5,9.5;3,1;back_main;Back]"
        formspec_index = formspec_index + 1
        
    elseif state.view_mode == "manage" then
        -- Manage party view
        formspec[formspec_index] = string.format("label[8,0.5;Manage Party: %s]", current_party_name or "Unknown")
        formspec_index = formspec_index + 1
        
        if current_party_data then
            -- Current members list
            formspec[formspec_index] = "label[1,2;Current Members:]"
            formspec_index = formspec_index + 1
            
            local member_list = {}
            for i, member in ipairs(current_party_data.members) do
                local status = ""
                if member == current_party_data.owner then
                    status = " (Owner)"
                end
                if minetest.get_player_by_name(member) then
                    status = status .. " [Online]"
                else
                    status = status .. " [Offline]"
                end
                table.insert(member_list, member .. status)
            end
            
            formspec[formspec_index] = string.format("textlist[1,2.8;7,4;member_list;%s;1;false]", 
                table.concat(member_list, ","))
            formspec_index = formspec_index + 1
            
            -- Add member section
            formspec[formspec_index] = "label[10,2;Add Member:]"
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = "field[10,2.8;5,1;add_member_name;;]"
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = "button[10,3.8;3,1;add_member;Add Member]"
            formspec_index = formspec_index + 1
            
            -- Remove member section (only show if there are members to remove)
            if #current_party_data.members > 1 then
                formspec[formspec_index] = "label[10,5;Remove Selected Member:]"
                formspec_index = formspec_index + 1
                
                formspec[formspec_index] = "button[10,5.8;3,1;remove_member;Remove Member]"
                formspec_index = formspec_index + 1
            end
            
            -- Delete party button (owner only)
            if is_owner then
                formspec[formspec_index] = "button[10,7.5;3,1;delete_party;Delete Party]"
                formspec_index = formspec_index + 1
            end
        end
        
        formspec[formspec_index] = "button[1,10.5;3,1;back_main;Back to Main]"
        formspec_index = formspec_index + 1
        
    elseif state.view_mode == "list" then
        -- List all parties view
        formspec[formspec_index] = "label[8,0.5;All Map Parties]"
        formspec_index = formspec_index + 1
        
        if next(parties) == nil then
            formspec[formspec_index] = "label[1,3;No parties exist]"
            formspec_index = formspec_index + 1
        else
            local party_list = {}
            for party_name, party_data in pairs(parties) do
                local online_count = 0
                for _, member in ipairs(party_data.members) do
                    if minetest.get_player_by_name(member) then
                        online_count = online_count + 1
                    end
                end
                
                local party_info = string.format("%s | Owner: %s | Members: %d (%d online)", 
                    party_name, party_data.owner, #party_data.members, online_count)
                table.insert(party_list, party_info)
            end
            
            formspec[formspec_index] = string.format("textlist[1,2;13,7;party_list;%s;1;false]", 
                table.concat(party_list, ","))
            formspec_index = formspec_index + 1
        end
        
        formspec[formspec_index] = "button[1,10.5;3,1;back_main;Back to Main]"
        formspec_index = formspec_index + 1
        
    elseif state.view_mode == "admin" then
        -- Admin management view
        formspec[formspec_index] = "label[8,0.5;Admin Party Management]"
        formspec_index = formspec_index + 1
        
        if next(parties) == nil then
            formspec[formspec_index] = "label[1,3;No parties exist]"
            formspec_index = formspec_index + 1
        else
            local party_list = {}
            for party_name, party_data in pairs(parties) do
                local party_info = string.format("%s | Owner: %s | Members: %d | Created: %s", 
                    party_name, party_data.owner, #party_data.members, 
                    os.date("%Y-%m-%d", party_data.created or 0))
                table.insert(party_list, party_info)
            end
            
            formspec[formspec_index] = string.format("textlist[1,2;13,6;admin_party_list;%s;1;false]", 
                table.concat(party_list, ","))
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = "button[1,9;3,1;admin_delete_selected;Delete Selected]"
            formspec_index = formspec_index + 1
            
            formspec[formspec_index] = "button[5,9;3,1;admin_view_details;View Details]"
            formspec_index = formspec_index + 1
        end
        
        formspec[formspec_index] = "button[1,10.5;3,1;back_main;Back to Main]"
        formspec_index = formspec_index + 1
    end
    
    -- Close button (always present)
    formspec[formspec_index] = "button[13,10.5;2,1;close;Close]"
    
    minetest.show_formspec(player_name, "persistent_map:party_gui", table.concat(formspec))
end

-- Handle formspec input
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "persistent_map:party_gui" then return end
    
    local player_name = player:get_player_name()
    local is_admin = is_server_admin(player_name)
    local current_party_name, current_party_data = get_player_party(player_name)
    local is_owner = current_party_name and is_party_owner(player_name, current_party_name)
    
    if not gui_state[player_name] then
        gui_state[player_name] = {view_mode = "main", selected_party = nil, scroll_pos = 0}
    end
    
    local state = gui_state[player_name]
    
    -- Handle navigation
    if fields.close or fields.quit then
        gui_state[player_name] = nil
        return
    elseif fields.back_main then
        state.view_mode = "main"
        persistent_map.show_party_gui(player_name)
        return
    elseif fields.create_party then
        if current_party_name then
            minetest.chat_send_player(player_name, S("You are already in a party. Leave it first."))
            return
        end
        state.view_mode = "create"
        persistent_map.show_party_gui(player_name)
        return
    elseif fields.manage_party then
        if not is_owner then
            minetest.chat_send_player(player_name, S("Only party owners can manage parties."))
            return
        end
        state.view_mode = "manage"
        persistent_map.show_party_gui(player_name)
        return
    elseif fields.list_parties then
        state.view_mode = "list"
        persistent_map.show_party_gui(player_name)
        return
    elseif fields.admin_manage then
        if not is_admin then
            minetest.chat_send_player(player_name, S("Admin privileges required."))
            return
        end
        state.view_mode = "admin"
        persistent_map.show_party_gui(player_name)
        return
    end
    
    -- Handle actions based on current view
    if state.view_mode == "create" then
        if fields.create_confirm then
            local party_name = fields.party_name or ""
            party_name = party_name:trim()
            
            if party_name == "" then
                minetest.chat_send_player(player_name, S("Party name cannot be empty."))
                return
            end
            
            -- Check if party already exists
            local parties = get_map_parties()
            if parties[party_name] then
                minetest.chat_send_player(player_name, S("Party '@1' already exists.", party_name))
                return
            end
            
            -- Create the party using the chat command system
            local initial_members = fields.initial_members or ""
            local cmd_params = "create " .. party_name
            
            if initial_members ~= "" then
                local members = initial_members:split("\n")
                for _, member in ipairs(members) do
                    member = member:trim()
                    if member ~= "" and member ~= player_name then
                        cmd_params = cmd_params .. " " .. member
                    end
                end
            end
            
            -- Execute the mapparty command
            local success, message = minetest.registered_chatcommands["mapparty"].func(player_name, cmd_params)
            minetest.chat_send_player(player_name, message)
            
            if success then
                state.view_mode = "main"
                persistent_map.show_party_gui(player_name)
            end
        end
        
    elseif state.view_mode == "manage" then
        if fields.add_member then
            local member_name = fields.add_member_name or ""
            member_name = member_name:trim()
            
            if member_name == "" then
                minetest.chat_send_player(player_name, S("Member name cannot be empty."))
                return
            end
            
            if not is_owner then
                minetest.chat_send_player(player_name, S("Only party owners can add members."))
                return
            end
            
            -- Use the mapparty command to add member
            local success, message = minetest.registered_chatcommands["mapparty"].func(
                player_name, "add " .. current_party_name .. " " .. member_name)
            minetest.chat_send_player(player_name, message)
            
            if success then
                persistent_map.show_party_gui(player_name)
            end
            
        elseif fields.remove_member then
            if not is_owner then
                minetest.chat_send_player(player_name, S("Only party owners can remove members."))
                return
            end
            
            local selected_idx = tonumber(fields.member_list) or 0
            if selected_idx > 0 and current_party_data and selected_idx <= #current_party_data.members then
                local member_to_remove = current_party_data.members[selected_idx]
                
                if member_to_remove == player_name then
                    minetest.chat_send_player(player_name, S("Use 'Leave Party' to remove yourself."))
                    return
                end
                
                -- Use the mapparty command to remove member
                local success, message = minetest.registered_chatcommands["mapparty"].func(
                    player_name, "remove " .. current_party_name .. " " .. member_to_remove)
                minetest.chat_send_player(player_name, message)
                
                if success then
                    persistent_map.show_party_gui(player_name)
                end
            else
                minetest.chat_send_player(player_name, S("Please select a member to remove."))
            end
            
        elseif fields.delete_party then
            if not is_owner then
                minetest.chat_send_player(player_name, S("Only party owners can delete parties."))
                return
            end
            
            -- Use the mapparty command to delete party
            local success, message = minetest.registered_chatcommands["mapparty"].func(
                player_name, "delete " .. current_party_name)
            minetest.chat_send_player(player_name, message)
            
            if success then
                state.view_mode = "main"
                persistent_map.show_party_gui(player_name)
            end
        end
        
    elseif state.view_mode == "admin" then
        if fields.admin_delete_selected then
            if not is_admin then
                minetest.chat_send_player(player_name, S("Admin privileges required."))
                return
            end
            
            local selected_idx = tonumber(fields.admin_party_list) or 0
            local parties = get_map_parties()
            local party_names = {}
            for party_name, _ in pairs(parties) do
                table.insert(party_names, party_name)
            end
            table.sort(party_names)
            
            if selected_idx > 0 and selected_idx <= #party_names then
                local party_to_delete = party_names[selected_idx]
                local party_data = parties[party_to_delete]
                
                -- Notify all members
                for _, member_name in ipairs(party_data.members) do
                    if minetest.get_player_by_name(member_name) then
                        minetest.chat_send_player(member_name, 
                            S("Map party '@1' has been deleted by admin @2", party_to_delete, player_name))
                    end
                end
                
                -- Delete the party
                parties[party_to_delete] = nil
                save_map_parties(parties)
                
                minetest.chat_send_player(player_name, S("Party '@1' deleted successfully.", party_to_delete))
                persistent_map.show_party_gui(player_name)
            else
                minetest.chat_send_player(player_name, S("Please select a party to delete."))
            end
            
        elseif fields.admin_view_details then
            local selected_idx = tonumber(fields.admin_party_list) or 0
            local parties = get_map_parties()
            local party_names = {}
            for party_name, _ in pairs(parties) do
                table.insert(party_names, party_name)
            end
            table.sort(party_names)
            
            if selected_idx > 0 and selected_idx <= #party_names then
                local party_name = party_names[selected_idx]
                local success, message = minetest.registered_chatcommands["mapparty"].func(
                    player_name, "info " .. party_name)
                minetest.chat_send_player(player_name, message)
            else
                minetest.chat_send_player(player_name, S("Please select a party to view details."))
            end
        end
    end
    
    -- Handle main view actions
    if state.view_mode == "main" then
        if fields.leave_party then
            if not current_party_name then
                minetest.chat_send_player(player_name, S("You are not in any party."))
                return
            end
            
            -- Use the mapparty command to leave party
            local success, message = minetest.registered_chatcommands["mapparty"].func(player_name, "leave")
            minetest.chat_send_player(player_name, message)
            
            if success then
                persistent_map.show_party_gui(player_name)
            end
        end
    end
end)

-- Clean up GUI state when players leave
minetest.register_on_leaveplayer(function(player)
    local player_name = player:get_player_name()
    gui_state[player_name] = nil
end)

-- Add button to marker GUI to access party management
local original_show_marker_gui = persistent_map.show_marker_gui
if original_show_marker_gui then
    function persistent_map.show_marker_gui(player_name)
        -- Call original function first
        original_show_marker_gui(player_name)
        
        -- We could modify the marker GUI to include a party management button
        -- but for now, we'll keep them separate
    end
end

-- Chat command to open party GUI
minetest.register_chatcommand("partygui", {
    description = S("Open the map party management GUI"),
    func = function(name)
        persistent_map.show_party_gui(name)
        return true, S("Party management GUI opened")
    end,
})

-- Add party management button to the main map GUI
local original_show_map = persistent_map.show_map
if original_show_map then
    -- We'll hook into the formspec handler instead to add the button
    local original_receive_fields = minetest.registered_on_player_receive_fields
    
    -- Register additional handler for map formspec to add party button
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "persistent_map:map" and fields.party_gui then
            local player_name = player:get_player_name()
            persistent_map.show_party_gui(player_name)
            return true
        end
    end)
end

minetest.log("action", "[persistent_map] Map party GUI system loaded successfully")