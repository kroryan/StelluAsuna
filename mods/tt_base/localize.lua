-- Localization of numbers. This allows to localize the decimal point,
-- infinity symbol and minus sign.

local S = minetest.get_translator("tt_base")
local INFINITY = 1/0
local NEG_INFINITY = -1/0

--~ symbol representing infinity
local INF_SYMBOL = S("∞")

tt_base.localize_number = function(numbr)
	if type(numbr) == "string" then
		numbr = tonumber(numbr)
		if type(numbr) ~= "number" then
			return numbr
		end
	end
	if minetest.is_nan(numbr) then
		return tostring(numbr)
	end
	if numbr == INFINITY then
		return INF_SYMBOL
	elseif numbr == NEG_INFINITY then
                --~ a negative whole number. @1 will be replaced by digits
		return S("−@1", INF_SYMBOL)
	end
	local negative
	if numbr < 0 then
		negative = true
		numbr = math.abs(numbr)
	end
	local pre = math.floor(numbr)
	local post = numbr % 1
	local str
	if post ~= 0 then
		post = string.sub(post, 3)
		if negative then
			--~ a negative number with some decimal places. @1 is the part before the decimal point, @2 is the part after it. Replace the minus sign and decimal point with whatever is appropriate for your language.
			str = S("−@1.@2", pre, post)
		else
			--~ a non-negative number with some decimal places. @1 is the part before the decimal point, @2 is the part after it. Replace the decimal point with whatever is appropriate for your language.
			str = S("@1.@2", pre, post)
		end
	elseif negative then
                --~ a negative whole number. @1 will be replaced by digits
		str = S("−@1", numbr)
	else
		str = tostring(numbr)
	end
	return str
end
