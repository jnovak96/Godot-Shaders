shader_type spatial;
render_mode blend_mix, cull_disabled;

uniform vec3 light_color : source_color;
uniform bool use_noise_for_emission_color = false;
uniform float alpha_multiplier = 1.0;
uniform float light_emission = 1.0;
uniform float light_scale = 1.0;
uniform float ray_movement_speed_x = 0;
uniform float rim_alpha = 1.0;
uniform float light_ray_distortion_speed = 0.05;
uniform sampler2D light_noise;
uniform sampler2D alpha_gradient;


void fragment() {
	vec2 uv_offset = vec2(ray_movement_speed_x, 0.1);
	vec2 uv_scale = vec2(light_scale, 1.0); 
	vec2 uv = UV * uv_scale + uv_offset.xy * TIME * 0.2;
	vec3 noise_tex = texture(light_noise, vec2(uv.x, TIME * light_ray_distortion_speed)).rgb;
	vec3 alpha_tex = texture(alpha_gradient, UV).rgb;
	float NdotV = dot(NORMAL, VIEW);
	float rim = pow(NdotV, rim_alpha);
	
	if (use_noise_for_emission_color) {
		EMISSION = noise_tex * light_emission;
	} else {
		EMISSION = light_emission + light_color;
	}		
	ALBEDO = noise_tex;
	ALPHA = noise_tex.y * rim * alpha_tex.r * alpha_multiplier;
}
