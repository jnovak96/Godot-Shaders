shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D albedo_texture;




void fragment() {
// Input:2
	vec4 n_out2p0 = COLOR;
	vec4 image = texture(albedo_texture, UV);


// Output:0
	ALBEDO = vec3(n_out2p0.xyz) * image.rgb;
	ROUGHNESS = 1.0;


}


void light() {
	// Called for every pixel for every light affecting the material.
}
