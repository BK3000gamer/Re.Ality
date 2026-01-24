shader_type canvas_item;

uniform float lod;
uniform float radius = 1.0;
uniform float amount = 0.25;
uniform float hdr_threshold = 2.0;

vec4 sample_glow_pixel(sampler2D tex, vec2 uv) {
	return max(textureLod(tex, uv, lod) - hdr_threshold, vec4(0.0));
}

uniform sampler2D screen_tex: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float r = radius;
	vec2 ps = SCREEN_PIXEL_SIZE * radius;
	vec4 col = texture(screen_tex, SCREEN_UV);
	
	vec4 glow = sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, 3.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, -3.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, 2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, -2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(0.0, 0.0) * ps);

	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, 3.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, -3.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, 2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, -2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(1.0, 0.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, 3.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, -3.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, 2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, -2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-1.0, 0.0) * ps);
	
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(2.0, 2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(2.0, -2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(2.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(2.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(2.0, 0.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-2.0, 2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-2.0, -2.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-2.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-2.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-2.0, 0.0) * ps);
	
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(3.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(3.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(3.0, 0.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-3.0, 1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-3.0, -1.0) * ps);
	glow += sample_glow_pixel(screen_tex, SCREEN_UV + vec2(-3.0, 0.0) * ps);
	
	glow *= amount;
	glow = min(glow, vec4(2.0));
	
	COLOR = vec4(col.rgb + glow.rgb, col.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
