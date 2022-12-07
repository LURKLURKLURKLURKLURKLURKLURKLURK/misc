local module = {}

local quartic = loadstring(game:HttpGet('https://raw.githubusercontent.com/LURKLURKLURKLURKLURKLURKLURKLURK/misc/main/CardanoFerrari.lua'))()

function module.solve_trajectory(origin,projectileSpeed,targetPos,targetVelocity,pickLongest,gravity)
	
	local g = gravity or workspace.Gravity

	local disp = targetPos - origin
	local p, q, r = targetVelocity.X, targetVelocity.Y, targetVelocity.Z
	local h, j, k = disp.X, disp.Y, disp.Z
	local number = -.5 * g 

	local solutions = quartic(
		l*l,
		-2*q*l,
		q*q - 2*j*l - projectileSpeed*projectileSpeed + p*p + r*r,
		2*j*q + 2*h*p + 2*k*r,
		j*j + h*h + k*k
	)
	if solutions then
		local posRoots = table.create(2)
		for _, v in solutions do --filter out the negative roots
			if v > 0 then
				table.insert(posRoots, v)
			end
		end
		if posRoots[1] then
			local t = posRoots[1]
			local d = (h + p*t)/t
			local e number = (j + q*t - l*t*t)/t
			local f number = (k + r*t)/t
			return origin + Vector3.new(d, e, f)
		end
	end
	return
end

return module
