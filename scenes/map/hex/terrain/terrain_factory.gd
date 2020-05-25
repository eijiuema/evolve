class_name TerrainFactory

enum Types {
	GRASS = 0
}

const TerrainScene = preload("res://scenes/map/hex/terrain/terrain.tscn")

static func make(type):
	
	var terrain = TerrainScene.instance()
	
	terrain.id = Types.GRASS
	
	match type:
		Types.GRASS:
			terrain.id = Types.GRASS
			terrain.sprite = 12
			terrain.travel_cost = 1
		_:
			push_error("Invalid terrain type")
			
	return terrain
