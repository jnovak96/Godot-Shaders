shader_type spatial;

uniform float uv_scale = 1.0;

uniform sampler2D drop_texture;
uniform sampler2D albedo_texture;
uniform sampler2D normalmap_texture;
uniform sampler2D height_texture;
uniform sampler2D noise_texture;

uniform float mix_ratio:hint_range(0.0, 1.0, 0.1);
varying float up;

void vertex() {
	// Called for every vertex the material is visible on.
	UV *= uv_scale;
	vec3 w_normal = normalize(MODEL_NORMAL_MATRIX * NORMAL);
	up = smoothstep(0.0, 0.1, w_normal.y);
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = texture(albedo_texture, UV).rgb;
	NORMAL_MAP = texture(normalmap_texture, UV).rgb;
	ROUGHNESS = texture(height_texture, UV).r;
	float noise = texture(noise_texture, UV).r;
	vec3 albedo_deform = texture(albedo_texture, UV + noise*0.2).rgb;
	
	vec4 drop = texture(drop_texture, UV);
	vec3 drop_normalmap = vec3(drop.x, drop.y, 1.0);
	float drop_mix_ratio = drop.b - TIME*0.3;
	drop_mix_ratio = fract(drop_mix_ratio)*drop.b + drop.a;
	drop_mix_ratio *= up;
	NORMAL_MAP = mix(NORMAL_MAP, drop_normalmap, drop_mix_ratio);
	//ROUGHNESS = mix(ROUGHNESS, 1.0, drop_mix_ratio);
	SPECULAR = mix(0.5, 1.0, drop_mix_ratio);
	ALBEDO = mix(ALBEDO, albedo_deform, drop_mix_ratio);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
