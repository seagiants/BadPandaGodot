extends TileMap

signal click_on_map(pos)

func _input(event):
	if (event.is_pressed() and "button_index" in event and event.button_index == BUTTON_LEFT):
		emit_signal("click_on_map",world_to_map(event.get_global_position()))
#
func tiled_position(glob_pos):
		var pos = world_to_map(glob_pos)
		var pos2 = map_to_world(pos) + get_cell_size()/2
		return pos2

func get_centered_cell_position(cell):
		var pos = map_to_world(cell) + get_cell_size()/2
		return pos
	
