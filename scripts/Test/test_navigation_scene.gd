extends Node2D

#vars
@onready var nodes: Array = $Waypoints.get_children()

@onready var navigation_region_2d: NavigationRegion2D = $NavigationRegion2D
@onready var drawer = $PathDrawer

var last_positions: Array[Vector2] = []
var map: RID

#func
func _ready():
	await wait_for_navigation_ready()
	map = get_world_2d().navigation_map

	cache_positions()
	update_path()
	
func _process(delta):
	if waypoints_changed():
		update_path()
		cache_positions()

	
func update_path():
	var path = build_path_through_nodes()
	drawer.set_path(path)


	
#get path for n nodes
func build_path_through_nodes() -> PackedVector2Array:
	var map = get_world_2d().navigation_map
	var final_path: PackedVector2Array = PackedVector2Array()
	
	for i in range(nodes.size() - 1):
		var segment = NavigationServer2D.map_get_path(
			map,
			nodes[i].global_position,
			nodes[i + 1].global_position,
			false
		)
		
		if segment.is_empty():
			continue
		
		# Avoid duplicating joint points
		if final_path.size() > 0:
			segment.remove_at(0)
		
		final_path.append_array(segment)
	
	return final_path

#helpers
#await for load
func wait_for_navigation_ready():
	var map = get_world_2d().navigation_map
	
	while NavigationServer2D.map_get_regions(map).is_empty():
		await get_tree().process_frame
	
#check if location of the nodes was changed	
func waypoints_changed() -> bool:
	for i in range(nodes.size()):
		if nodes[i].global_position != last_positions[i]:
			return true
	return false
	
#cache positions for each node
func cache_positions():
	last_positions.clear()
	for node in nodes:
		last_positions.append(node.global_position)
