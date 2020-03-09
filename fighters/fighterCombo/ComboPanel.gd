extends Panel

const Fighter = preload("res://fighters/fighter.gd")
const Combo = preload("res://fighters/fighterCombo/fighterCombo.gd")
func _ready():
#	var panel = Fighter.get_panel("Red")
#	var cont = ContainerCombo.new()
#	cont.props = {"color": "Red"}
#	get_child(0).add_child(cont)
#	panel.set_custom_minimum_size(Vector2(32,32))
#	panel.set_size(Vector2(32,32))
#	panel.set_mouse_filter(MOUSE_FILTER_PASS)
#	cont.add_child(panel)
	if not(comboResolver.connect("combo_matched",self,"on_combo_matched")):
		print("Impossible de connecter le comboresolver au Panel")
#	add_combo(Combo.new({"color":"Yellow"}))
#	add_combo(Combo.new({"color":"Red"}))
#	add_combo(Combo.new({"color":"Green"}))
	
func add_combo(combo):
	get_child(0).add_child(combo)

func on_combo_matched(combo):
	add_combo(combo)
