
minetest.register_on_joinplayer(function(player)
	player:hud_set_hotbar_itemcount(24)
	player:hud_set_hotbar_image("place_hotbar.png")

	player:get_inventory():set_size("main", 24)
	for i = 1, 24, 1 do
		player:get_inventory():set_stack("main", i, ItemStack("place:colour_"..i))
	end

	player:set_sky{
		base_color = "#333355",
		type = 'plain',
		clouds = false
	}

	player:set_sun{
		visible = false,
		sunrise_visible = false
	}

	player:set_moon{ visible = false }

	player:set_stars{ visible = false }

	player:override_day_night_ratio(0.8)

	player:set_physics_override{ speed = 3 }

	-- Give fly and fast privs
	local playername = player:get_player_name()
	local pri = minetest.get_player_privs(playername)
	pri["fly"] = true
	pri["fast"] = true
	minetest.set_player_privs(playername, pri)

	player:set_inventory_formspec([[
		size[12,3.5]
		label[0,0;Your palette:]
		list[current_player;main;0,0.75;12,2;]
		label[0,3;(You can swap colours around to paint easier. It will be reset on next join.)]
	]])
end)

minetest.register_on_newplayer(function(player)
	player:set_pos({ x = 256, y = 2, z = 256 })
end)
