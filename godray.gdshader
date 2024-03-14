shader_type spatial;
render_mode blend_mix;

uniform vec3 light_color : source_color;
uniform float light_falloff = 1.0;
uniform float light_emission = 1.0;
uniform float ray_resolution = 100;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform float ray_movement_speed = 0.1;
uniform sampler2D iChannel0;


void vertex() {
	vec2 uv_offset = vec2(ray_movement_speed, 0.0);
	UV = UV * uv_scale.xy + uv_offset.xy * TIME * 0.2;
}

void fragment() {
// ColorParameter:3
	//vec4 color = light_color;
	//vec4 albedo_tex = texture(ray_image, UV);
	//vec3 ray_color = vec3(color.xyz);

	
	
	
	
	
	//vec2 coord = (FRAGCOORD.xy);
	float ray_color = 0.0;
	//float a = sin(TIME);
	//float b = sin(TIME * 5.43) * 0.4;
	//float c = sin(TIME * 8.72) * 0.3;
	ray_color += sin(UV.x * ray_resolution) * 0.5;

	EMISSION = vec3(ray_color, ray_color, ray_color) + light_color * light_emission;
	ALBEDO = vec3(TIME*3.0, ray_color, ray_color) ;
	ALPHA = UV.g * light_falloff;
}
