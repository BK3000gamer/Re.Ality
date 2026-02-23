shader_type spatial;
render_mode unshaded, blend_add, depth_draw_never,fog_disabled,specular_disabled,ambient_light_disabled,shadows_disabled;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform sampler2D sprite_texture: source_color, filter_nearest;
uniform float amount = 0.25;

void vertex() {
	// Billboard Mode: Enabled
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			MAIN_CAM_INV_VIEW_MATRIX[0],
			MAIN_CAM_INV_VIEW_MATRIX[1],
			MAIN_CAM_INV_VIEW_MATRIX[2],
			MODEL_MATRIX[3]);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	vec4 sprite_col = texture(sprite_texture, UV);
	sprite_col.a *= amount;

	ALBEDO = sprite_col.rgb;
	ALPHA = sprite_col.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
