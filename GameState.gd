extends Node
#Used for logs
const tab = "------"

var final_score = 0

var _config = {
	"ennemiesPool" : {"Knight":2,"SimpleBlue":4,"SimpleRed":3},
	"cell_init_ennemies" : Vector2(11,13),
	"cell_princess" : Vector2(11,3),
	"size_hand" : 3,
	#Used for the clickable zone of ennemies sprites. WIP.
	"cell_size" : Vector2(32,32)
}

func get_ennemiesPool():
	return _config.ennemiesPool
	
func get_cell_size():
	return _config.cell_size

func set_ennemiesPool(ep):
	_config.ennemiesPool = ep

func get_cell_init_ennemies():
	return _config.cell_init_ennemies

func get_cell_princess():
	return _config.cell_princess

func get_size_hand():
	return _config.size_hand
