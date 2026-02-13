extends Node2D

var path: PackedVector2Array = PackedVector2Array()

func set_path(new_path: PackedVector2Array):
	path = new_path
	queue_redraw()

func _draw():
	if path.size() > 1:
		draw_polyline(path, Color.RED, 4.0)
