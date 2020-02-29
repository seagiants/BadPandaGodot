extends Node2D

var cellPosition setget set_cellPosition,get_cellPosition
var step
onready var sprite = $EnnemySprite

signal ennemy_moved(dest,target)

func _ready():
	add_to_group("ENNEMIES")

func get_cellPosition():
	return cellPosition

func set_cellPosition(pos):
	var oldPosition = cellPosition
	cellPosition = pos
	emit_signal("ennemy_moved",get_name(),oldPosition,pos)

func move():
#	print(get_name())
	var newCell = cellPosition + Vector2(0,-1)
	var newPosition = sprite.get_global_position() + Vector2(0,-step[1])
	sprite.set_modulate(Color( 1, 0, 0, 1 ))
	set_position(newPosition)
	set_cellPosition(newCell)
