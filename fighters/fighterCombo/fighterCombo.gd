extends Container

const Fighter = preload("res://fighters/fighter.gd")

var props

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init(nprops):
	if nprops.color:
		set_custom_minimum_size(Vector2(32,32))
		var panel = Fighter.get_panel(nprops.color)
		props = nprops
		panel.set_custom_minimum_size(Vector2(32,32))
		panel.set_size(Vector2(32,32))
		panel.set_mouse_filter(MOUSE_FILTER_PASS)
		add_child(panel)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_drag_data(_pos):
	#Create a copy of the dragged item to show the drag
	var ei = self.get_child(0).duplicate()
	set_drag_preview(ei)
	return self

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
