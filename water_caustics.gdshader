shader_type spatial;

uniform sampler2D noise_texture;
uniform sampler2D color_ramp;
uniform vec4 color : source_color;
uniform float scale = 1.0;


vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

float worley(vec2 uv, float columns, float rows) {
	
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));
	
	float minimum_dist = 1.0;  
	
	for (int y= -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);
			
			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			minimum_dist = min(minimum_dist, dist);
		}
	}
	
	return minimum_dist;
}

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	float worley = worley(world_position.xz * scale + TIME * 0.25, 3.0, 3.0);
	float worley_normalized = texture(color_ramp, vec2(worley)).r;
	//color = min(0.999, color);
	worley_normalized = log(0.995) / log(worley_normalized);
	worley_normalized *= 50.0;
	EMISSION = vec3(worley_normalized) * color.rgb;
	ALPHA = worley_normalized;
}
