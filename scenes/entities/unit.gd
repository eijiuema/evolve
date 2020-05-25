extends Node2D

signal path_finished

export var SPEED := 100

var map
var lodging : Lodging
var goal : Goal

var path : Array setget set_path

func init(lodging_: Lodging, map_):
	lodging = lodging_
	map = map_

func _ready():
	set_process(false)
	
func _process(delta):
	var move_distance = SPEED * delta
	move_along_path(move_distance)
	
func move_along_path(distance: float):
	var start_point = position
	for i in path.size():
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next:
			$Sprite.flip_h = position.x > path[0].x
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif path.size() == 1:
			position = path[0]
			set_process(false)
			emit_signal("path_finished")
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		
func set_path(value):
	path = value
	if path.size() == 0:
		return
	set_process(true)
