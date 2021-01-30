tool
extends Panel

var shader_time := 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	material.set_shader_param('iTime', shader_time)
	shader_time += delta
