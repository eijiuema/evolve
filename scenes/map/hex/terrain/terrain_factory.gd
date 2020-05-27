class_name TerrainFactory

enum Types {
	GRASS = 0,
	WATER = 1,
	MOUNTAIN = 2,
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
		Types.WATER:
			terrain.id = Types.WATER
			terrain.sprite = 76
			terrain.travel_cost = INF
		Types.MOUNTAIN:
			terrain.id = Types.MOUNTAIN
			terrain.sprite = 40
			terrain.travel_cost = INF
		_:
			push_error("Invalid terrain type")
			
	return terrain
