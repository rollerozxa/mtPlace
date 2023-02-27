
-- Less verbose file include function taken from NodeCore
-- https://gitlab.com/sztest/nodecore/-/blob/master/mods/nc_api/init.lua
local include = rawget(_G, "include") or function(...)
	local parts = {...}
	table.insert(parts, 1, minetest.get_modpath(minetest.get_current_modname()))
	if parts[#parts]:sub(-4) ~= ".lua" then
		parts[#parts] = parts[#parts] .. ".lua"
	end
	return dofile(table.concat(parts, "/"))
end
rawset(_G, "include", include)

-- Override the hand tool
minetest.override_item("", {
	range = 50,
})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	return true
end)

include("api")
include("nodes")
include("mapgen")
include("player")
