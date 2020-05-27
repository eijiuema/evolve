extends AStar

class_name PathFinder

var ids: Dictionary = {}

func add_hex(pos: Vector3, weight: float, neighbours: Array):
	if not ids.has(pos):
		ids[pos] = get_available_point_id()
	var id = ids[pos]
	add_point(id, pos, weight)
	for neighbour in neighbours:
		if ids.has(neighbour):
			var neighbour_id = ids[neighbour]
			if are_points_connected(id, neighbour_id):
				connect_points(id, neighbour_id)

func remove_hex(pos: Vector3):
	if ids.has(pos):
		var id = ids[pos]
		if has_point(id):
			remove_point(ids[pos])
		return ids.erase(pos)
	return false

func get_path(a: Vector3, b: Vector3):
	if ids.has(a) and ids.has(b):
		return get_point_path(ids[a], ids[b])
	else:
		return []
