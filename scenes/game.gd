extends Node2D

class_name Game

const Map = preload("res://scenes/map/map.tscn")

onready var map = $Map

func new_game():
	map.queue_free()
	map = Map.instance()
	add_child(map)
		
func serialize():
	return {
		"map": map.serialize()
	}
	
func unserialize(data):
	map.unserialize(data.map)
