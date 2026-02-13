extends Node2D

#vars
@onready var test_node_1: Node2D = $TestNode1
@onready var test_node_2: Node2D = $TestNode2
@onready var navigation_region_2d: NavigationRegion2D = $NavigationRegion2D
@onready var drawer = $PathDrawer
@onready var label: Label = $Label

#func
func _ready():
	await wait_for_navigation_ready()
	await NavigationServer2D.map_changed
	print("map_changed")
	await get_tree().process_frame

	var map = get_world_2d().navigation_map

	var path = NavigationServer2D.map_get_path(
		map,
		test_node_1.global_position,
		test_node_2.global_position,
		false
	)
	print("Map: " + str(map))
	print("Path found: " + str(path))

	print("Point A:", test_node_1.global_position)
	print("Point B:", test_node_2.global_position)
	
	label.text = str(path)
	drawer.set_path(path)

func _process(delta):
	update_path()
	
func update_path():
	var map = get_world_2d().navigation_map
	
	var path = NavigationServer2D.map_get_path(
		map,
		test_node_1.global_position,
		test_node_2.global_position,
		false
	)
	
	drawer.set_path(path)
	
func wait_for_navigation_ready():
	var map = get_world_2d().navigation_map
	
	while NavigationServer2D.map_get_regions(map).is_empty():
		await get_tree().process_frame
