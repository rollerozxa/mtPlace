
-- Simple formspec wrapper that does variable substitution.
function formspec_wrapper(formspec, variables)
	local retval = formspec

	for k,v in pairs(variables) do
		retval = retval:gsub("${"..k.."}", v)
	end

	return retval
end

-- Shortened colour functions to do MCLawl-like coloured command messages
function yellow(msg)	return minetest.colorize("#ffff33", msg) end
function red(msg)		return minetest.colorize("#ff3333", msg) end
function green(msg)		return minetest.colorize("#33ff33", msg) end
 
