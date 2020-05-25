extends Node2D

class_name Map

onready var hex_map = $HexMap
onready var hex_container = $HexContainer
onready var indicator = $Indicator
onready var path_finder := PathFinder.new()

var selected_pos : Vector3

const Hex = preload("res://scenes/map/hex/hex.tscn")
const Unit = preload("res://scenes/entities/unit.tscn")
		
func add_hex(pos: Vector3, hex: Hex):
	if hex_map.has_hex(pos):
		return
	hex.position = hex_map.hex_to_pixel(pos)
	hex_container.add_child(hex)
	hex_map.set_hex(pos, hex)
	path_finder.add_hex(pos, hex.travel_cost, hex_map.hex_neighbours(pos))
	
func remove_hex(pos: Vector3):
	if not hex_map.has_hex(pos):
		return
	path_finder.remove_hex(pos)
	hex_map.get_hex(pos).queue_free()
	hex_map.remove_hex(pos)

func _input(event):
	if event is InputEventMouseMotion:
		selected_pos = hex_map.pixel_to_hex(to_local(get_global_mouse_position()))
		indicator.position = hex_map.hex_to_pixel(selected_pos)
		indicator.visible = true
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_RIGHT:
			if hex_map.has_hex(selected_pos):
				remove_hex(selected_pos)
			else:
				var hex = Hex.instance()
				hex.terrain = TerrainFactory.make(TerrainFactory.Types.GRASS)
				add_hex(selected_pos, hex)

func serialize():
	var hexes = hex_map.get_all_hex()
	var hexes_data = {}
	
	for hex in hexes:
		hexes_data[var2str(hex)] = hexes[hex].serialize()
	
	var save_dict = {
		"hexes": hexes_data
	}
	
	return save_dict
	
func unserialize(data):
	for pos in data.hexes:
		var hex = Hex.instance()
		hex.unserialize(data.hexes[pos])
		add_hex(str2var(pos), hex)
