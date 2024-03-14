shader_type spatial;
render_mode blend_mix;

//void vertex() {
    //// Calculate model-view matrix
    //mat4 modelview = INV_VIEW_MATRIX * MODEL_MATRIX;
//
    //// Calculate normal in view space
    //vec3 viewSpaceNormal = normalize((modelview * vec4(NORMAL, 0.0)).xyz);
//
    //// Set normals to be perpendicular to the camera (in view space)
    //NORMAL = viewSpaceNormal;
//}

void vertex() {
    vec3 centerNormal = vec3(0.0, 0.0, 0.0);

    // Sum up normals of neighboring vertices
    for (int i = 0; i < 8; i++) {  // Consider 8 neighboring vertices (adjust as needed)
        centerNormal += NORMAL;  // Assuming NORMAL is the normal attribute passed to the shader
    }

    // Normalize the sum to get an average normal
    centerNormal = normalize(centerNormal);

    // Use centerNormal for further calculations or pass it to the fragment shader
    NORMAL = centerNormal;
}


void fragment() {
    // Calculate the dot product between the view direction and normal
	vec3 viewDir = normalize(VIEW);
    float dotProduct = dot(viewDir, normalize(NORMAL));
	ALPHA = dotProduct * 2.0;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
