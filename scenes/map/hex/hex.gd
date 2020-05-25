extends Node2D

class_name Hex

var terrain : Terrain setget set_terrain
var travel_cost setget , get_travel_cost

func set_terrain(value: Terrain):
	if terrain:
		terrain.queue_free()
	terrain = value
	add_child(terrain, true)

func get_travel_cost():
	return terrain.travel_cost

func serialize():
	return {
		"terrain": terrain.serialize()
	}

func unserialize(data):
	self.terrain = TerrainFactory.make(str2var(data.terrain))
