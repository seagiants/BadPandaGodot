extends Node
const Combo = preload("res://fighters/fighterCombo/fighterCombo.gd")
signal combo_matched(combo)

func match_combo(score):
	for key in score.keys():
		if score[key].value >= 2:
			var cName = score[key].type+"x3-Combo"
			var props = {
				key : score[key].type,
				"comboName": cName
				}
			emit_signal("combo_matched",Combo.new(props))
