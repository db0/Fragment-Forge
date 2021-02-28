tool
extends Panel

var shader_time := 0.0
var frame := 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	material.set_shader_param('iTime', shader_time)
	material.set_shader_param('iFrame', frame)
	shader_time += delta
	frame += 1
	material.set_shader_param("iChannelResolution1", Vector2(512, 512))
