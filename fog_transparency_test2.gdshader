shader_type spatial;
uniform sampler2D noise_img;
uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset;
uniform float rate;
uniform vec4 fog_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	//UV = UV * tiling + offset * TIME;
	COLOR.rgb = fog_color.rgb;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv1 = vec2(UV.x - TIME * rate, UV.y);
	vec2 uv2 = vec2(UV.x + TIME * rate, UV.y);
	vec2 uv3 = vec2(UV.x , UV.y + TIME * rate * 2.0);
		
	float noise_r = texture(noise_img, uv1).r;
	float noise_g = texture(noise_img, uv2).g;
	float noise_b = texture(noise_img, uv3).b;
	
	vec3 new_color = vec3(noise_r, noise_g, noise_b);
	
	ALBEDO.rgb = new_color;	
	EMISSION.rgb = vec3(.6, 0, 0);
	
	ALPHA = UV.g * .5;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
