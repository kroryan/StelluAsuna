minetest.register_on_mods_loaded(function()
	local nodes = {}
	-- Iterate through all nodes, select nodes allowed to be cut
	-- Only the regular, solid blocks without metas or explosivity can be cut
	for nodename, def in pairs(minetest.registered_nodes) do
		if xdecor.stairs_valid_def(def) then
			if not xdecor.is_cut_registered(nodename) then
				if xdecor.can_cut(nodename) then
					table.insert(nodes, nodename)
				else
					-- Not all of the available node names are available
					-- for X-Decor-libre to add: Skip this node
					minetest.log("action", "[xdecor_autocut] Skipped adding cut nodes for "..nodename.." because at least one of the required nodenames is already taken")
				end
			end
		end
	end
	for n=1, #nodes do
		xdecor.register_cut(nodes[n])
		minetest.log("action", "[xdecor_autocut] Registered cut nodes for: "..nodes[n])
	end
end)
