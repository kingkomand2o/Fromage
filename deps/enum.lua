return function(list)
	local reversed = { }

	for k, v in next, list do
		if reversed[v] then
			return error("Enumeration conflict in '" .. tostring(k) .. "' and '" .. tostring(reversed[v]) .. "'")
		end
		reversed[v] = k
	end

	return setmetatable({ }, {
		__index = function(_, index)
			return list[index]
		end,
		__call = function(_, value)
			return reversed[value]
		end,
		__pairs = function()
			return next, list
		end,
		__newindex = function()
			return error("Can not overwrite enumerations.")
		end
	})
end