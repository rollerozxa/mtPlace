local storage = minetest.get_mod_storage()

local hypertext_text = [[
<center><big>Welcome to <b>mtPlace</b>!</big></center>

mtPlace is a canvas 512x512 pixels in size. You have 24 colours at your disposal. What will you make?
Inspired by the Reddit r/place social experiments that took place during 2017 and 2022, mtPlace is a collaborative canvas hosted as a Minetest server. You paint the canvas by placing nodes on it within Minetest, and it will show up on the map that updates every minute.
What you draw in-game will be visible on the website (<style color=#8888ff>mtplace.voxelmanip.se</style>), which gets updated every 5 minutes.

<big>Rules</big>
mtPlace is not intended to be complete chaos or anarchy. Destructive vandalism of existing creations is not allowed and will be rolled back. Offensive symbols or other imagery interpreted as offensive by staff will also be rolled back.
If you are found to be disruptive you may have your interact privileges revoked by the discretion of the staff.

Feel ready to start? <action name=security><style color=#00ff00>Click here to answer the verification question.</style></action>
]]

local formspec_text = formspec_wrapper([[
		formspec_version[4]
		size[14,11]
		box[0.25,0.25;13.5,9.5;#00000088]
		hypertext[0.5,0.5;13,9;welcometext;${hypertext_text}]
		button_exit[4.5,9.9;5,0.9;btn_confirm;OK]
	]], { hypertext_text = hypertext_text })

local security_formspec_text = [[
	formspec_version[4]
	size[13.25,7]
	hypertext[0.5,0.75;13,10;lol;In order to be granted interact privileges you need to answer this question.

	What is the square root of  <mono>floor(pi) * 48</mono> ?]
	field[0.5,3.5;12,0.8;answer;;]
	${error}
	button[7.5,5;5,0.9;btn_confirm;Submit]
]]

local function show_welcome_formspec(playername)
	minetest.show_formspec(playername, 'place_server:welcomescreen', formspec_text)
end

local function show_security_formspec(playername, wrong)
	local errormsg = ''
	if wrong then
		errormsg = "label[1,5.5;"..red("Wrong answer!").."]"
	end

	minetest.show_formspec(playername, 'place_server:welcomescreen',
		formspec_wrapper(security_formspec_text, {
			error = errormsg
		}))
end

local function revoke_interact(name)
	local pri = minetest.get_player_privs(name)
	pri["interact"] = nil
	minetest.set_player_privs(name, pri)
end

local function verified(name)
	return storage:get_int(name) == 1
end

local function success(name)
	-- check for interact ban
	if not no_touch_griefer.check_ban(minetest.get_player_ip(name)) then
		storage:set_int(name, 1)

		local pri = minetest.get_player_privs(name)
		pri["interact"] = true
		minetest.set_player_privs(name, pri)

		minetest.chat_send_player(name, green("You answered the question correctly and have now been granted interact privileges!"))
		minetest.close_formspec(name, "place_server:welcomescreen")
	else
		-- ew
		minetest.chat_send_player(name, red("LOL you're still interact banned."))
	end
end

minetest.register_on_joinplayer(function(player, last_login)
	local name = player:get_player_name()
	if not verified(name) then
		revoke_interact(name)
		show_welcome_formspec(name)
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= 'place_server:welcomescreen' then return end
	local name = player:get_player_name()

	if fields.welcometext == 'action:security' then
		if not verified(name) then
			show_security_formspec(name)
		else
			minetest.chat_send_player(name, yellow("You're already verified!"))
		end
	elseif fields.answer then
		if tonumber(fields.answer) == 12 then
			success(name)
		else
			show_security_formspec(name, true)
		end
	else
		if not verified(name) then
			minetest.chat_send_player(name, yellow("Use /welcome to reshow the welcome page. You cannot interact until you've answered the verification question."))
		end
	end
end)

minetest.register_chatcommand("welcome", {
	params = "",
	description = "Reshow the welcome screen.",
	func = function(name, param)
		show_welcome_formspec(name)
	end
})
