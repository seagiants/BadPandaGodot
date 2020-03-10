extends PanelContainer

const InfoPanel = preload("InfoPanel.tscn")
var labelHp

func _init():
	hide()

func add_ennemy_info(ennemy):
	add_ennemy_sprite(ennemy.ennemyName)
	for stat in ennemy.stats:
		add_stat_info(stat,ennemy.stats[stat])
	
func add_ennemy_sprite(ennemyName):
#	var center = CenterContainer.new()
	var sprite = load("res://ennemies/ennemySprites/"+ennemyName+"Info.tscn").instance()
#	sprite.set_frame(2)
	sprite.set_stretch_mode(6)
#	sprite.texture.set_stretch_mode(4)
	$HBoxContainer/TextureRect.texture = sprite.get_texture()

func add_stat_info(stat,labelText):
	var newPanelInfo = InfoPanel.instance()	
	var infoSplit = HSplitContainer.new()
	newPanelInfo.add_child(infoSplit)
	var centerTexture = CenterContainer.new()
	centerTexture.size_flags_horizontal = SIZE_EXPAND_FILL
	centerTexture.size_flags_vertical = SIZE_EXPAND_FILL
	infoSplit.add_child(centerTexture)
#	print("res://ennemies/ennemySprites/"+stat+"Texture.tscn")
	var statTexture = load("res://ennemies/ennemySprites/statSprites/"+stat+"Texture.tscn").instance()
	statTexture.set_stretch_mode(4)
	centerTexture.add_child(statTexture)
	var label = Label.new()
	label.set_text(str(labelText))
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	label.size_flags_vertical = SIZE_EXPAND_FILL
	label.align = 1
	label.valign = 1
	infoSplit.add_child(label)
	if stat != "hp":
		$HBoxContainer/VBoxContainer.add_child(newPanelInfo)
	else : 
		self.labelHp = label
		newPanelInfo.set_size(Vector2(0,0))
		$HBoxContainer/HpBox.add_child(newPanelInfo)
