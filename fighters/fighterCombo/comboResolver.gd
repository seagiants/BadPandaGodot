extends Node
const Combo = preload("res://fighters/fighterCombo/fighterCombo.gd")
signal combo_matched(combo)

func match_combo(score):
	if score.color.value >= 3:
		var props = {"color":score.color.type}
		emit_signal("combo_matched",Combo.new(props))
