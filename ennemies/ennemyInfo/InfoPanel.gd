extends MarginContainer
#
#onready var statLabel = $PanelContainer2/HSplitContainer/MarginContainer2/Label
#onready var textureSt = $PanelContainer2/HSplitContainer/MarginContainer

func init(stat,statText):
	$PanelContainer2/HSplitContainer/MarginContainer2/Label.set_text(statText)
	var StatTexture = load("res://ennemies/ennemySprites/statSprites/"+stat+"Texture.tscn")
	$PanelContainer2/HSplitContainer/MarginContainer.add_child(StatTexture.instance())
