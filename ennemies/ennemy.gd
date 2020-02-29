extends Node2D
#Used to store position on map
var cellPosition setget set_cellPosition,get_cellPosition
#range in pixels for a move (based on cell_size)
var step
#Stats see ennemyLib.gd
var stats

var hp setget set_hp, get_hp

#Ennemy name
var ennemyName
#Name of the corresponding info node, used to hide it when ennemy dies
var infoNode
#Sprite of the ennemy
onready var sprite = get_child(0)

var clickz
#Fired each time cellPosition is setted.
signal ennemy_moved(dest,target)
signal ennemy_hovered(ennemy)
signal ennemy_hovered_end(ennemy)
## Creating a new ennemy :
# - Adding EnnemyName.tscn (could be sprite sheet for anim)
# - Adding EnnemyNameInfo.tscn (needed to be a single sprite)
# - Adding the needed statSprite.tscn et statSpriteTexture.tscn
# - Adding an entry in ennemyLib.gd
func _init(nname,nstats):
	var ennemySprite = load("res://ennemies/ennemySprites/"+nname+".tscn").instance()
	add_child(ennemySprite)
	ennemyName = nname
	stats = nstats.duplicate()
	hp = stats.hp
	var clickZone = Control.new()
	clickZone.set_size(Vector2(50,50))
	add_child(clickZone)
	clickZone.connect("mouse_entered",self,"on_hover")
	clickZone.connect("mouse_exited",self,"on_hover_end")

func set_hp(nhp):
	hp = nhp
	infoNode.labelHp.set_text(str(nhp))

func get_hp():
	return hp
	
func on_hover():
	emit_signal("ennemy_hovered",self)

func on_hover_end():
	emit_signal("ennemy_hovered_end",self)
		
func _ready():
	add_to_group("ENNEMIES")

func get_cellPosition():
	return cellPosition

func set_cellPosition(pos):
	var oldPosition = cellPosition
	cellPosition = pos
	emit_signal("ennemy_moved",get_name(),oldPosition,pos)

func move():
	var newCell = cellPosition + Vector2(0,-1)
	var newPosition = sprite.get_global_position() + Vector2(0,-step[1])
	set_position(newPosition)
	set_cellPosition(newCell)
