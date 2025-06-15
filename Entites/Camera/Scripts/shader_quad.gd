extends MeshInstance3D

@onready var subviewport_texture :Texture= $"../../SubViewportContainer/SubViewport".get_texture()

func _ready():
	var shader_mat := get_active_material(0)
	if shader_mat == null:
		push_warning("No material found on mesh!")
		return
	
	if shader_mat is ShaderMaterial:
		shader_mat.set_shader_parameter("sub_viewport_texture", subviewport_texture)
