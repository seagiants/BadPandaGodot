extends Node2D

const Princess = preload("res://Princess.tscn")
const HandSlot = preload("res://DraggableContainer.tscn")
const FighterLib = preload("res://fighters/fighterFactory.gd")
const EnnemyLib = preload("res://ennemies/ennemyFactory.gd")
const EnnemyInfoPanel = preload("res://ennemies/ennemyInfo/EnnemyInfoPanel.tscn")
const TextProvider = preload("res://textProvider.gd")
onready var map = $TileMap
onready var hand = $HandPanel
onready var step = $TileMap.get_cell_size()
onready var handLabel = $HandTitlePanel/Label
onready var endButton = $EndTurn
var ennemiesCount = 0 
var pool = FighterLib.new() 
var ennemyPool
var mapState = {}
var fighterSelected = null setget set_fighter_selected
var currentPhase = "pick" setget set_phase

func set_fighter_selected(nfight):
	if fighterSelected != null :
		fighterSelected.clickedPanel.hide()
	fighterSelected = nfight
	if nfight != null:
		fighterSelected.clickedPanel.show()
		
	
	
func set_phase(nphase):
	endButton.visible = !endButton.visible
	currentPhase = nphase
	handLabel.set_text(TextProvider.get_phase_text(nphase))
	if nphase == "keep":
		hide_matches()

func is_wall(cell):
	if cell[0] == 1:
		return true
	if cell[0] == 13:
		return true
	if cell[1] == 1:
		return true
	if cell[1] == 12:
		return true
	if cell[1] == 11:
		return true
	else:
		return false

func init_wall():
	for cell in map.get_used_cells():
		if is_wall(cell):
			mapState[cell] = {"wall": true}
		else :
			mapState[cell] = {}

func init_ennemies():
	ennemyPool = EnnemyLib.new(GameState.get_ennemiesPool())
	var ennemy = ennemyPool.spawn()
	add_ennemy(ennemy,GameState.get_cell_init_ennemies())

func init_hand(fighter_keeped = null):
	self.currentPhase = "pick"
	for child in hand.get_children():
		#Keeping the selected fighter
		if fighter_keeped == null or child.get_child(0).get_name() != fighter_keeped.get_name():
			child.queue_free()
	for i in range(GameState.get_size_hand()):
		var fighter
		if (i==0 and fighter_keeped != null):
			fighter_keeped.get_parent().set_position(Vector2(i*100+26,26))
		else:
			fighter = pool.draw()
			if fighter == null :
				break
			else: 
				var container = HandSlot.instance()
				container.add_child(fighter)
				container.set_position(Vector2(i*100+26,26))
				hand.add_child(container)
				fighter.connect("fighter_selected",self,"on_fighter_picked")
	

func on_fighter_picked(_event,fighter):
	hide_matches()
	if self.fighterSelected == fighter :
		self.fighterSelected = null
		return
	self.fighterSelected = fighter
	if currentPhase == "pick":
		get_tree().call_group("FIGHTERS","show_match",fighter.color,fighter.clas,fighter.race)
		show_match_on_cell(fighter.color,fighter.clas,fighter.race)
	elif currentPhase == "keep":
		endTurn()
	
func _ready():
	var _connected = statResolver.connect("score_modified",self,"on_score_modified")
	_connected = endButton.connect("pressed",self,"on_click_endTurn")
	_connected = map.connect("click_on_map",self,"on_click_on_map")
	_connected = comboResolver.connect("combo_matched",self,"on_combo_matched")
	init_wall()
	init_ennemies()
	init_hand()
	add_princess()
	
func on_click_endTurn():
	endTurn()

func on_score_modified(stat,new_score):
	var tab = GameState.tab
	var text = tab + stat
	addLog(text)
	text =  tab + tab + to_log(new_score)
	addLog(text)

func on_combo_matched(combo):
	var tab = GameState.tab
	var text = tab + "Combo : "+combo.props.comboName
	addLog(text)
	

func to_log(score):
		var score_int = scoreResolver.get_score_int(score)
		return "Score "+str(score_int)+" :  "+str(score.color.type)+":"+str(score.color.value)+"/"+str(score.clas.type)+":"+str(score.clas.value)+"/"+str(score.race.type)+":"+str(score.race.value)

func on_click_on_map(cell):
	if currentPhase == "pick" and cell in mapState:
		var cellState = mapState[cell]
		if "content" in cellState:
			pass
#			addLog(str(cell)+" : Ho ! Y a déjà qqn là !")
		elif "wall" in mapState[cell]:
			pass
#			addLog(str(cell)+" : Ah non, je monte pas sur un mur !")
		elif self.fighterSelected != null:		
			resolve(fighterSelected,cell)			
			add_fighter(fighterSelected,cell)
			self.currentPhase = "keep"
			self.fighterSelected = null
#			endTurn()
		else:
			pass
#			addLog("C'est pas le chateau ici !'")

func resolve(fighter,cell):
	var tab = GameState.tab
	addLog("Fighter ("+str(fighter.color)+","+str(fighter.clas)+","+str(fighter.race)+") sur ("+str(cell[0])+","+str(cell[1])+")")
	var score = get_score(cell,fighter.color,fighter.clas,fighter.race)
	var score_int = scoreResolver.get_score_int(score)
	if score_int == 0:
		addLog(tab+"Score : 0... looser...")
	else:
		addLog(tab+"Score "+str(score_int)+" :  "+str(score.color.type)+":"+str(score.color.value)+"/"
			+str(score.clas.type)+":"+str(score.clas.value)+"/"+str(score.race.type)+":"+str(score.race.value))
		comboResolver.match_combo(score)
		var ennemies = get_tree().get_nodes_in_group("ENNEMIES")	
		if ennemies.size() == 0:
	#		addLog("Y a personne sur qui taper ??'")
			return 0
		var ennemy = ennemies[0]
		for stat in ennemy.stats:
			if stat != "hp":
				score = statResolver.resolve_stat(ennemy.stats,stat,score)
		var damage = scoreResolver.get_score_int(score)
		if damage == 0 :
			pass
		elif damage >= ennemy.hp:
			addLog(tab+ennemy.ennemyName+" est mort")
			remove_ennemy(ennemy)
		else:
			addLog(tab+ennemy.ennemyName+" prend "+str(damage)+" dommages")
			ennemy.hp -= damage
		
func remove_ennemy(ennemy):
		mapState[ennemy.cellPosition].erase("content")
		ennemy.show_death()
		ennemy.infoNode.queue_free()
		ennemy.add_to_group("DEADS")
		ennemy.remove_from_group("ENNEMIES")
		GameState.final_score += 1
#		ennemy.queue_free()

func to_int_index(vect_index):
	return str(vect_index[0])+"-"+str(vect_index[1])
	
func add_fighter(fighter,cell):
#	var fighter = newFighter("Green","Bow","Human")
	fighter.set_position(map.get_centered_cell_position(cell)-Vector2(16,16))
	var container = fighter.get_parent()
	container.remove_child(fighter)
	container.queue_free()
	add_child(fighter)
	fighter.add_to_group("FIGHTERS")
	fighter.onMap = 1
	mapState[cell].content = fighter.get_name()
#	addLog(str(cell)+ " : Je me mets là, tiens.")

func on_ennemy_hovered(ennemy):
#	var pop = $BottomBox.get_node(ennemy.infoNode)
#	pop.set_position(Vector2(480,80))
#	pop.show()
	ennemy.infoNode.show()

func on_ennemy_hovered_end(ennemy):
	ennemy.infoNode.hide()
#	$BottomBox.get_node(ennemy.infoNode).hide()
	
func add_ennemy(ennemy,cell):
	ennemiesCount += 1
	ennemy.set_position(map.get_centered_cell_position(cell))
	ennemy.set_cellPosition(cell)
	ennemy.step = step
	add_child(ennemy)
	ennemy.connect("ennemy_hovered",self,"on_ennemy_hovered")
	ennemy.connect("ennemy_hovered_end",self,"on_ennemy_hovered_end")
	mapState[cell].content = ennemy.get_name()
	ennemy.connect("ennemy_moved",self,"on_ennemy_moved")
	var ennemyInfo = EnnemyInfoPanel.instance()
	ennemyInfo.add_ennemy_info(ennemy)
	$BottomBox.add_child(ennemyInfo)
	ennemyInfo.hide()
#	ennemy.infoNode = ennemyInfo.get_name()
	ennemy.infoNode = ennemyInfo
	
func add_princess():
	var princess = Princess.instance()
	var cell = GameState.get_cell_princess()
	princess.set_position(map.get_centered_cell_position(cell))
	add_child(princess)
	mapState[cell].content = "Princess"


func on_ennemy_moved(ennemy,orig,target):
	if orig in mapState and mapState[orig].content == ennemy:
		mapState[orig].erase("content")
	if target in mapState:
		if target == GameState.get_cell_princess():
			var _over = get_tree().change_scene("res://GameOver.tscn")
		else:
			mapState[target].content = ennemy
	
func addLog(text):
	$LogContainer/LogLabel.add_text(text+'\n')

func endTurn():
	init_hand(fighterSelected)
	self.fighterSelected = null
	hide_matches()
	get_tree().call_group("ENNEMIES","move")
	for deads in get_tree().get_nodes_in_group("DEADS"):
		deads.queue_free()
	if ennemyPool.count() > 0:
		var ennemy = ennemyPool.spawn()
		add_ennemy(ennemy,GameState.get_cell_init_ennemies())
	if not(get_tree().has_group("ENNEMIES")):	
			var _over = get_tree().change_scene("res://GameOver.tscn")	



func get_score(cell,color,clas,race):
	var score = {
		"color": {"type":color,"value":0},
		"race": {"type":race,"value":0},
		"clas": {"type":clas,"value":0}
	}
	for neighb in get_neighbours(cell):
		if neighb in mapState:
			var fight = get_fighter(neighb)
			if fight != null:
				var matchF = get_node(fight).matchFighter(color, clas, race) 
				for i in matchF:
					score[i].value = score[i].value + matchF[i].value
	return score

func show_match_on_cell(color,clas,race):
	for cell in mapState:
		if not("content" in mapState[cell]) and is_wall(cell) == false:			
			var score = scoreResolver.get_score_int(get_score(cell,color,clas,race))
			if score > 0 :
				show_match_score(cell,score)

		
func get_fighter(cell):
	if not(cell in mapState):
		return null
	if not("content" in mapState[cell]):
		return null
	else:
		if "content" in mapState[cell] and "FIGHTERS" in get_node(mapState[cell].content).get_groups():
			return mapState[cell].content
		else:
			return null
	
func show_match_score(cell, score):
	var lab = Label.new()
	lab.set_text(str(score))
	lab.set_position(map.get_centered_cell_position(cell))
	lab.add_to_group("SHOWS")		
	add_child(lab)

func hide_matches():
	get_tree().call_group("FIGHTERS","hide_match")
	for show in get_tree().get_nodes_in_group("SHOWS"):
		show.queue_free()

func get_neighbours(cell):
	return [cell - Vector2(1,0),cell + Vector2(1,0),cell - Vector2(0,1),cell + Vector2(0,1)]		
