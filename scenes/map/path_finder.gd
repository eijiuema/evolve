extends AStar

class_name PathFinder

var ids: Dictionary = {}

func add_hex(hex: Vector3, weight: int, neighbours: Array):
	if ids.has(hex):
		add_point(ids[hex], hex, weight)
	else:
		ids[hex] = get_available_point_id()
		add_point(ids[hex], hex, weight)
		for neighbour in neighbours:
			if ids.has(neighbour):
				connect_points(ids[hex], ids[neighbour])

func remove_hex(hex: Vector3):
	if ids.has(hex):
		remove_point(ids[hex])
		return ids.erase(hex)
	return false

func get_path(a: Vector3, b: Vector3):
	if ids.has(a) and ids.has(b):
		return get_point_path(ids[a], ids[b])
	else:
		return []
