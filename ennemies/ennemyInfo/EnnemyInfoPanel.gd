extends PanelContainer

const InfoPanel = preload("InfoPanel.tscn")

func _ready():
	hide()
	
func set_hp(nhp):
	$HSplitContainer/VSplitContainer/CenterContainer/PanelContainer3/MarginContainer/HSplitContainer/Label.set_text(str(nhp))
				
func add_ennemy_info(ennemy):
	var sprite = load("res://ennemies/ennemySprites/"+ennemy.ennemyName+"Info.tscn").instance()
	$HSplitContainer/VSplitContainer/MarginContainer2.add_child(sprite)
	for stat in ennemy.stats:
		var statLabel = ennemy.stats[stat]
		if stat == "hp":
			$HSplitContainer/VSplitContainer/CenterContainer/PanelContainer3/MarginContainer/HSplitContainer/Label.set_text(str(statLabel))
		else:	
			var newStat = InfoPanel.instance()
			newStat.init(stat,statLabel)
			$HSplitContainer/VBoxContainer.add_child(newStat)
