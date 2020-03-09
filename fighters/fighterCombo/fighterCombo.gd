extends PanelContainer

const Fighter = preload("res://fighters/fighter.gd")

var props
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init(nprops):
	size_flags_horizontal = 0
	size_flags_vertical = 0
	var ncombo
	props = nprops
	set_custom_minimum_size(Vector2(32,32))
	if nprops.has("color"):
		ncombo = Fighter.get_panel(nprops.color)
		ncombo.set_mouse_filter(MOUSE_FILTER_PASS)
	if nprops.has("clas"):
		ncombo = Fighter.get_sprite(nprops.clas)
		ncombo.centered = false
		ncombo.set_position(Vector2(8,8))
	if nprops.has("race"):
		ncombo = Fighter.get_sprite(nprops.race)
		ncombo.centered = false
		ncombo.set_position(Vector2(4,4))
	add_child(ncombo)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_drag_data(_pos):
	#Create a copy of the dragged item to show the drag
	var ei = self.get_child(0).duplicate()
	var cont = Container.new()
#	if props.has("color"):
#		cont = Container.new()
#	else:
#		cont = PanelContainer.new()
	cont.add_child(ei)
	print(ei)
	set_drag_preview(cont)
	return self

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
