shader_type spatial;
uniform sampler2D img;
uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset;

void vertex() {
	// Called for every vertex the material is visible on.
	UV = UV * tiling + offset * TIME;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 image = texture(img, UV);
	ALBEDO = vec3(image.xyz);
	ALPHA = image.a * UV.g;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
