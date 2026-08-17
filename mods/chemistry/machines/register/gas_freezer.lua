
local S = chemistry.getter

local function insert_object_unique_stack(pos, node, incoming_stack, direction)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local incoming_name = incoming_stack:get_name()
	local stack_index = nil
	for inv_index, inv_stack in pairs(inv:get_list("src")) do
		if inv_stack:get_name() == incoming_name then
			stack_index = inv_index
			break
		end
	end
	if stack_index == nil then
		return inv:add_item("src", incoming_stack)
	end
	local present_stack = inv:get_stack("src", stack_index)
	local leftover = present_stack:add_item(incoming_stack)
	inv:set_stack("src", stack_index, present_stack)
	return leftover
end

local function can_insert_unique_stack(pos, node, incoming_stack, direction)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local incoming_name = incoming_stack:get_name()
	if meta:get_int("splitstacks") == 0 then
		-- avoid looping second time with inv:contains_item("src", incoming_stack)
		for _, inv_stack in pairs(inv:get_list("src")) do
			if inv_stack:get_name() == incoming_name then
				return inv_stack:item_fits(incoming_stack)
			end
		end
	end

	return technic.default_can_insert(pos, node, incoming_stack, direction)
end

function technic.register_gas_freezer(data)
	data.typename = "gas_freeze"
	data.machine_name = "gas_freezer"
	data.machine_desc = ("@1 Gas Freezer")

	data.insert_object = insert_object_unique_stack
	data.can_insert = can_insert_unique_stack

	technic.register_base_machine(data)
end

