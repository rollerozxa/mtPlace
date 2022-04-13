
local nodes = {
	"be0039",
	"ff4500",
	"ffa800",
	"ffd635",
	"00a368",
	"00cc78",
	"7eed56",
	"00756f",
	"009eaa",
	"2450a4",
	"3690ea",
	"51e9f4",
	"493ac1",
	"6a5cff",
	"811e9f",
	"b44ac0",
	"ff3881",
	"ff99aa",
	"6d482f",
	"9c6926",
	"000000",
	"898d90",
	"d4d7d9",
	"ffffff",
}

for id, colour in pairs(nodes) do
	tile = "^[resize:16x16^[colorize:#"..colour..":255"

	minetest.register_node("place:colour_"..id, {
		tiles = {tile},
		inventory_image = tile,
		wield_scale = {x = 0, y = 0, z = 0},
		drop = "",
		node_placement_prediction = "air",
		groups = {snappy=3},
		on_place = function(itemstack, user, pointed_thing)
			minetest.set_node(pointed_thing.under, { name = itemstack:to_string() })
		end
	})
end