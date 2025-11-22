I was about to drift off to sleep when a thought popped into my head. It occurred to me that I would be able to use 3D noise generated in Filter Forge for a planetary surface with erosion in World Machine if I changed the coordinate mapping from equirectangular to a 3D polar coordinate output in 2 passes, north and south. 

Could you revise this that way? (I'd use two instances with the same settings, so I'd be adding an inversion checkbox for the z-coorinate.)  

**convert from spherical coordinates to polar coordinates**

rho, theta, phi to x, y, z where:

x = math.cos(theta) * math.cos(phi) * radius
y = math.sin(theta) * math.cos(phi) * radius
z = math.sin(phi) * radius

then cartesian to polar coordinates where:

radius = math.sqrt(x^2 + y^2)

so the angle in the new polar coordinate system is the angle in the 𝑥, 𝑦 plane:  theta_polar = math.atan2(y, x)

```
function prepare()
	-- v.002.7.1
	details = get_intslider_input(DETAILS)
	aspect = OUTPUT_HEIGHT / OUTPUT_WIDTH * 2
	set_perlin_noise_seed(get_intslider_input(SEED))
	if (get_checkbox_input(HDR)) then
		hdr = true
	else
		hdr = false
	end
end;

function get_sample(x, y)
	local r, g, b, a = get_sample_map(x, y, BACKGROUND)
	local r2, g2, b2, a2 = get_sample_map(x, y, FOREGROUND)
	local roughness = 3.75 - get_sample_grayscale(x, y, ROUGHNESS) * 4.375 + 0.01
	local contrast = (get_sample_grayscale(x, y, CONTRAST) * 2) - 1
	local factor = (259 * (contrast + 1)) / (1 * (259 - contrast))
	local v = 0
	local osx, osy,  osz, osa = get_sample_map(x, y, OFFSET)
	local dx, dy, dz, da = get_sample_map(x, y, DISTORTION) -- * 2
	local sx, sy, sz, sa = get_sample_map(x, y, SCALE)
	local s = 500
	local amp = 1
	sx, sy, sz, sa  = sx * 1.25, sy * 1.25, sz * 1.25, sa * 1.25
	local x = x * aspect * math.pi
	local y = y * math.pi
	local nx = math.cos(x) * math.sin(y) * (sx * sa) + (osx * osa)
	local ny = math.sin(x) * math.sin(y) * (sy * sa) + (osy * osa)
	local nz = math.cos(y) * (sz * sa) + (osz * osa)
	for oct = 1, details do
		local d1 = get_perlin_noise(nx+1,ny,nz,s) * (dx * da)
		local d2 = get_perlin_noise(nx+2,ny,nz,s) * (dy * da)
		local d3 = get_perlin_noise(nx+3,ny,nz,s) * (dz * da)
		if oct == 1 then v = get_perlin_noise(nx+d1,ny+d2,nz+d3,s) else
			v = (v + get_perlin_noise(nx+d1/oct,ny+d2/oct,nz+d3/oct,s) * amp ) / (1 + amp)
		end
		nz = nz * 2
		s = s / 2
		amp = amp / roughness
	end
	v  = truncate(factor * (v - 0.5) + 0.5)
	v = get_sample_curve(x,y,v,PROFILE)
	local opacity = v
	r, g, b, a = blend_normal(r, g, b, a, r2, g2, b2, a2, opacity, hdr)
--	return dx, dy, dz, da
	return r, g, b, a
end;

function truncate(value)
	if value <= 0 then value = 0 end
	if value >= 1 then value = 1 end
	return value
end;
```


