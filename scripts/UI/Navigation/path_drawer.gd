extends Node2D

#VARS
#consts
var DISTANCE_BETWEEN_STARS = 80.0
#locals
var path: PackedVector2Array = PackedVector2Array()
var star_texture = preload("res://scenes/UI/star.tscn")

func set_path(new_path: PackedVector2Array):
	pass
	'''path = new_path
	queue_redraw()'''

func draw_stars(new_path: PackedVector2Array):
	clear_all()
	
	path = new_path
	print("In draw_stars " + str(path.size()))
	for i in range(path.size() - 1):
		var start = path[i]
		var end = path[i + 1]
		
		var seg_len = start.distance_to(end)
		var dir = (end - start).normalized()
		print("Segment length:", seg_len)
		var steps = int(seg_len / DISTANCE_BETWEEN_STARS) 
		
		for j in range(steps):
			print("Star instantiated")
			var pos = start + dir * j * DISTANCE_BETWEEN_STARS
			
			var star = star_texture.instantiate()
			star.position = pos
			add_child(star)
		 
func _draw():
	pass
	'''if path.size() > 1:
		draw_polyline(path, Color.RED, 4.0)'''
		
func clear_all():
	path.clear()

	for child in get_children():
		child.queue_free()
