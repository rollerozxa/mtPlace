
minetest.register_node("place:barrier", {
	description = "Invisible Barrier",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	diggable = false,
	buildable_to = false,
	sunlight_propagates = true,
	groups = { not_in_creative_inventory = 1 }
})

local node = minetest.get_content_id("place:colour_23")
local barrier = minetest.get_content_id("place:barrier")

local data = {}

local size = 512

if minetest.get_mapgen_setting('mg_name') == "singlenode" then
	minetest.register_on_generated(function(minp, maxp, blockseed)
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
		vm:get_data(data)

		for z = minp.z, maxp.z do
		for y = minp.y, maxp.y do
			local posi = area:index(minp.x, y, z)
			for x = minp.x, maxp.x do
				if (x >= 0 and x < size) and (z >= 0 and z < size) then
					if y == 0 then
						data[posi] = node --minetest.get_content_id("place:colour_"..math.random(1,3))
					elseif y < 0 then
						data[posi] = barrier
					end
				else
					data[posi] = barrier
				end

				posi = posi + 1
			end
		end
		end

		vm:set_data(data)
		vm:write_to_map()
	end)
end

-- Protect the MTPLACE.VOXELMANIP.SE sign in the bottom left corner
function minetest.is_protected(pos, name)
	if pos.x >= 0 and pos.x < 86 and pos.z >= 0 and pos.z < 9 then
	--and name ~= "ROllerozxa" and name ~= "singleplayer" then
		return true
	end

	return false
end
