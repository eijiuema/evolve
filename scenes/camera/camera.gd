extends Camera2D

const MIN_ZOOM = 0.5
const MAX_ZOOM = 10000.0
const ZOOM_STEP = 0.5

onready var tween = $Tween

var mouse_captured = false
var current_zoom = 1.0
	
func _input(event):
	if mouse_captured and event is InputEventMouseMotion:
		offset -= event.get_relative() * zoom

func _unhandled_input(event):
	handle_drag(event)
	handle_zoom(event)
	
func handle_drag(event):
	if event.is_action_pressed("map_drag"):
		mouse_captured = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	elif event.is_action_released("map_drag"):
		mouse_captured = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func handle_zoom(event):
	if event.is_action_pressed("map_zoom_out"):
		if current_zoom < MAX_ZOOM:
			current_zoom += ZOOM_STEP
			tween.interpolate_property(self, "zoom", zoom, current_zoom * Vector2.ONE, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()

	elif event.is_action_pressed("map_zoom_in"):
		if current_zoom > MIN_ZOOM:
			current_zoom -= ZOOM_STEP
			tween.interpolate_property(self, "zoom", zoom, current_zoom * Vector2.ONE, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
