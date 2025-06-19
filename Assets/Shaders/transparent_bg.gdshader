shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_always;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
    ALBEDO = vec3(0.0);
    ALPHA = 0.0;
}