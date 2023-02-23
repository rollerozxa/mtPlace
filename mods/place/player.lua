
minetest.register_on_joinplayer(function(player)
	player:hud_set_hotbar_itemcount(24)
	player:hud_set_hotbar_image("place_hotbar.png")

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

	player:set_moon{
		visible = false
	}

	player:set_stars{
		visible = false
	}

	player:override_day_night_ratio(0.8)

	player:set_physics_override{
		speed = 3
	}

	-- Give fly and fast privs
	local playername = player:get_player_name()
	local pri = minetest.get_player_privs(playername)
	pri["fly"] = true
	pri["fast"] = true
	minetest.set_player_privs(playername, pri)
end)
