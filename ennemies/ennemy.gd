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
var tweenNode
#Sprite of the ennemy
onready var sprite

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
	sprite = ennemySprite
	ennemyName = nname
	var tween = Tween.new()
	add_child(tween)
	tweenNode = tween
	stats = nstats.duplicate()
	hp = stats.hp
	var clickZone = Control.new()
	clickZone.set_size(GameState.get_cell_size())
	clickZone.set_position(-GameState.get_cell_size()/2)
	add_child(clickZone)
	clickZone.connect("mouse_entered",self,"on_hover")
	clickZone.connect("mouse_exited",self,"on_hover_end")

func show_death():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tweenNode.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tweenNode.is_active():
			tweenNode.start()

func set_hp(nhp):
	hp = nhp
	infoNode.set_hp(str(nhp))

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
	tweenNode.interpolate_property(self, "position", get_position(), newPosition, 0.9, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if sprite.has_node("AnimationPlayer"):
		sprite.get_node("AnimationPlayer").play("walk_up")
	if not tweenNode.is_active():
			tweenNode.start()
#	set_position(newPosition)
	set_cellPosition(newCell)
	
