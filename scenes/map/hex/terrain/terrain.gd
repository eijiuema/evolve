extends Node2D

class_name Terrain

var id : int
var sprite : int setget set_sprite
var travel_cost : float

func set_sprite(value):
	sprite = value
	$Sprite.frame = value

func serialize():
	return var2str(id)

func _on_VisibilityNotifier2D_screen_entered():
	show()
	print("showing")

func _on_VisibilityNotifier2D_screen_exited():
	hide()
	print("hiding")
