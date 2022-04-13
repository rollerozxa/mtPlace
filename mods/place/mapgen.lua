local node = minetest.get_content_id("place:colour_1")

local data = {}

local size = 500

if minetest.get_mapgen_setting('mg_name') == "singlenode" then
	minetest.register_on_generated(function(minp, maxp, blockseed)
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
		vm:get_data(data)

		for z = minp.z, maxp.z do
		for y = minp.y, maxp.y do
		for x = minp.x, maxp.x do
			if y == 0 and (x >= -size and x <= size) and (z >= -size and z <= size)  then
				data[area:index(x, y, z)] = minetest.get_content_id("place:colour_"..math.random(23,23))
			end
		end
		end
		end

		vm:set_data(data)
		vm:write_to_map()
	end)
end
