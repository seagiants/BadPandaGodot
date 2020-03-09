extends Container

# Called when the node enters the scene tree for the first time.
func _ready():
	set_scale(Vector2(2,2))

func can_drop_data(_pos, _data):
	return true

#Fired when dropping a node on it
func drop_data(_pos, data):
	var fight = get_child(0)
	fight.color = data.props.color
	fight.set_panel(data.get_child(0))
