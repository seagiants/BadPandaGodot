extends Node
#Used for logs
const tab = "------"

var final_score = 0

var _config = {
	"nb_init_ennemies" : 3,
	"cell_init_ennemies" : Vector2(11,13),
	"cell_princess" : Vector2(11,3),
	"size_hand" : 3
}

func get_nb_init_ennemies():
	return _config.nb_init_ennemies

func get_cell_init_ennemies():
	return _config.cell_init_ennemies

func get_cell_princess():
	return _config.cell_princess

func get_size_hand():
	return _config.size_hand
