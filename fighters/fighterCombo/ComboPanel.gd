extends Panel

const Fighter = preload("res://fighters/fighter.gd")
const Combo = preload("res://fighters/fighterCombo/fighterCombo.gd")

func _ready():
	if not(comboResolver.connect("combo_matched",self,"on_combo_matched")):
		print("Impossible de connecter le comboresolver au Panel")
	
func add_combo(combo):
	get_child(0).add_child(combo)

func on_combo_matched(combo):
	add_combo(combo)
