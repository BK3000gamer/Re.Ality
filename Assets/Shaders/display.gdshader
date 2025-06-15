shader_type spatial;
render_mode blend_mix, depth_prepass_alpha;

uniform sampler2D sub_viewport_texture;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	vec4 tex_color = texture(sub_viewport_texture, UV);
	ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
