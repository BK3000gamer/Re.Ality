shader_type spatial;

render_mode cull_disabled;

uniform vec4 albedo : source_color = vec4(1.0f);
uniform sampler2D albedo_texture : source_color;
uniform sampler2D alpha_tex : source_color;

uniform int cuts : hint_range(1, 8) = 3;
uniform float wrap : hint_range(-2.0f, 2.0f) = 0.0f;
uniform float steepness : hint_range(1.0f, 8.0f) = 1.0f;

void vertex() {
    vec3 local_center = vec3(0.0);

    vec3 world_center = (MODEL_MATRIX * vec4(local_center, 1.0)).xyz;

    mat3 view_rot = mat3(
        INV_VIEW_MATRIX[0].xyz,
        INV_VIEW_MATRIX[1].xyz,
        INV_VIEW_MATRIX[2].xyz
    );

    vec3 offset = view_rot * VERTEX;

    vec3 new_local = (inverse(MODEL_MATRIX) * vec4(world_center + offset, 1.0)).xyz;

    VERTEX = new_local;
	NORMAL = vec3(0.0, 1.0, 0.0); // or your ground normal
}

void fragment() {
    ALBEDO = albedo.rgb * texture(albedo_texture, UV).rgb;
	float tex_alpha = texture(alpha_tex, UV).a;
	ALPHA = tex_alpha;
}

void light() {
	// Attenuation.
	float attenuation = 1.0f;
	attenuation = ATTENUATION;
	
	// Diffuse lighting.
	float NdotL = dot(NORMAL, LIGHT);
	float diffuse_amount = NdotL + (attenuation - 1.0) + wrap;
	//float diffuse_amount = NdotL * attenuation + wrap;
	diffuse_amount *= steepness;
	float cuts_inv = 1.0f / float(cuts);
	float diffuse_stepped = clamp(diffuse_amount + mod(1.0f - diffuse_amount, cuts_inv), 0.0f, 1.0f);
	
	float border = 0.0f;
	
	vec3 diffuse = ALBEDO.rgb * LIGHT_COLOR / PI;
	diffuse *= diffuse_stepped * (1.0f - border);
	
	DIFFUSE_LIGHT += diffuse;
}