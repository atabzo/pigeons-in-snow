extends Node2D

#function for getting a path between 2 vectors
#returns PackedVector2Array - efficient array of vector2ds.
func get_navigation_path(from: Vector2, to: Vector2, nav_region: NavigationRegion2D) -> PackedVector2Array:
	await get_tree().process_frame
	print("Nav pass started")
	var map_rid = nav_region.get_navigation_map()
	print("Map: " + str(map_rid))
	if map_rid == RID():
		push_warning("NavigationRegion2D has no map RID; is it inside a Navigation2D node?")
		return PackedVector2Array()

	# Debug: Check polygon
	var poly: NavigationPolygon = nav_region.navigation_polygon
	if poly:
		var vertices := poly.get_vertices()
		print("Polygon vertex count: ", vertices.size())
		print("Polygon vertices: ", vertices)
		var polygon_count := poly.get_polygon_count()
		print("Polygon count: ", polygon_count)
		for i in range(polygon_count):
			print("Polygon %s indices: %s" % [i, poly.get_polygon(i)])
	else:
		push_warning("NavigationRegion2D is missing a NavigationPolygon resource")

	print("Region enabled: ", nav_region.enabled)
	print("Region position: ", nav_region.global_position)

	# Snap the requested points onto the navigable surface so the query succeeds.
	var start_point := NavigationServer2D.map_get_closest_point(map_rid, from)
	var end_point := NavigationServer2D.map_get_closest_point(map_rid, to)
	print("Closest start point on navmesh:", start_point)
	print("Closest end point on navmesh:", end_point)
	if start_point == Vector2.INF or end_point == Vector2.INF:
		push_warning("Start or end is outside the navigation polygon")
		return PackedVector2Array()

	var path = NavigationServer2D.map_get_path(
		map_rid,
		start_point,
		end_point,
		true # smooth the path
	) # runs A* for the shortest path between the two points

	if path.is_empty():
		print("No valid path found")
		return PackedVector2Array()

	return path
