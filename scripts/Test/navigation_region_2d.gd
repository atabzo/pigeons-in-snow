extends NavigationRegion2D


# Called when the node enters the scene tree for the first time.
'''func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	var nav_poly = NavigationPolygon.new()
	
	var vertices = PackedVector2Array([
		Vector2(-100, -100),
		Vector2(1100, -100),
		Vector2(1100, 700),
		Vector2(-100, 700)
	])
	nav_poly.add_outline(vertices)
	
	nav_poly.make_polygons_from_outlines()
	
	self.navigation_polygon = nav_poly
	
	bake_navigation_polygon()'''
