extends Node2D

class_name Terrain

var id : int
var sprite : int setget set_sprite
var travel_cost : int

func set_sprite(value):
	sprite = value
	$Sprite.frame = value

func serialize():
	return var2str(id)
