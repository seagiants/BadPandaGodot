extends PanelContainer

#const HpTexture = preload("res://ennemies/ennemySprites/hpTexture.tscn")

func init(stat,labelText):
#	var infoPanel = PanelContainer.new()
#	add_child(infoPanel)
	var infoSplit = HSplitContainer.new()
	add_child(infoSplit)
	var centerTexture = CenterContainer.new()
	centerTexture.size_flags_horizontal = SIZE_EXPAND_FILL
	centerTexture.size_flags_vertical = SIZE_EXPAND_FILL
	infoSplit.add_child(centerTexture)
	print("res://ennemies/ennemySprites/"+stat+"Texture.tscn")
	var statTexture = load("res://ennemies/ennemySprites/"+stat+"Texture.tscn").instance()
	statTexture.set_stretch_mode(4)
	centerTexture.add_child(statTexture)
	var label = Label.new()
	label.set_text(str(labelText))
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	label.size_flags_vertical = SIZE_EXPAND_FILL
	label.align = 1
	label.valign = 1
	infoSplit.add_child(label)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
