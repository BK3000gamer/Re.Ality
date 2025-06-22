extends MeshInstance3D

var subviewport: SubViewport

func init(ViewportName: String) -> void:
	var greatGreatGrandParent = get_parent().get_parent().get_parent().get_parent()
	
	var sibling = greatGreatGrandParent.get_node_or_null(ViewportName)
	if sibling is SubViewport:
		subviewport = sibling

func _ready():
	init("Main")
	var subviewport_texture :Texture= subviewport.get_texture()
	print(subviewport_texture)
	var shader_mat := get_active_material(0)
	if shader_mat == null:
		push_warning("No material found on mesh!")
		return
	
	if shader_mat is ShaderMaterial:
		shader_mat.set_shader_parameter("sub_viewport_texture", subviewport_texture)
