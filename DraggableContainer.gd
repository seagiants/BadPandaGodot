extends Container

# Called when the node enters the scene tree for the first time.
func _ready():
	set_scale(Vector2(2,2))

func can_drop_data(_pos, _data):
	return true

#Fired when dropping a node on it
func drop_data(_pos, data):
	var fight = get_child(0)
	for key in data.props.keys():
		if key == "comboName":
			continue
		fight[key] = data.props[key]
		match key:
			"color":
				fight.set_panel(data.get_child(0))
			"race":
				fight.set_race_sprite(data.get_child(0))
			"clas":
				fight.set_clas_sprite(data.get_child(0))
