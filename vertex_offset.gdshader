shader_type spatial;
render_mode cull_back;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0, 0.1);
uniform float vertex_offset_intensity = 0.1;
uniform float emission_strength = 0.1;
uniform sampler2D texture_albedo;
uniform vec3 color : source_color = vec3(1.0);

void vertex() {
	UV = UV * uv_scale.xy + uv_offset.xy * TIME * 0.2;
	vec4 albedo_tex = textureLod(texture_albedo, UV, 0);
	VERTEX += NORMAL * albedo_tex.r * vertex_offset_intensity;
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.	
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	vec3 albedo_color = albedo_tex.rgb * color;
	ALBEDO = albedo_color;
	EMISSION = albedo_color * emission_strength;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
