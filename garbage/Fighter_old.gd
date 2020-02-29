extends Node2D

const human = preload("res://fighterSprite/Human.tscn")
const orc = preload("res://fighterSprite/Orc.tscn")
const elf = preload("res://fighterSprite/Elf.tscn")
const ghost = preload("res://fighterSprite/Ghost.tscn")
const sword = preload("res://fighterSprite/Sword.tscn")
const bow = preload("res://fighterSprite/Bow.tscn")
const wand = preload("res://fighterSprite/Wand.tscn")
const shield = preload("res://fighterSprite/Shield.tscn")
const red = preload("res://fighterSprite/Red.tscn")
const blue = preload("res://fighterSprite/Blue.tscn")
const green = preload("res://fighterSprite/Green.tscn")
const yellow = preload("res://fighterSprite/Yellow.tscn")
var color
var clas
var race
var raceSprite
var clasSprite
var colorSprite
var onMap

signal fighter_selected(fighter)

func _init(ncolor,nclas,nrace):
	onMap = 0
	color = ncolor
	clas = nclas
	race = nrace
	colorSprite = get_sprite(ncolor)
	add_child(colorSprite)
	raceSprite = get_sprite(nrace)
	add_child(raceSprite)
	raceSprite.set_position(Vector2(12,12))
	clasSprite = get_sprite(nclas)
	add_child(clasSprite)
	clasSprite.set_position(Vector2(26,12))
	var clickZone = Control.new()
	clickZone.set_size(Vector2(64,64))
	add_child(clickZone)
	clickZone.connect("gui_input",self,"on_click")
	
func _ready():
	pass # Replace with function body.
	

func on_click(event):
	if onMap == 1:
		return
	if (event.is_pressed() and "button_index" in event and event.button_index == BUTTON_LEFT):
		emit_signal("fighter_selected",self)
	

func get_sprite(carac):
	if carac == "Sword":
		return sword.instance()
	elif carac == "Bow":
		return bow.instance()
	elif carac == "Wand":
		return wand.instance()
	elif carac == "Shield":
		return shield.instance()
	elif carac == "Red":
		return red.instance()
	elif carac == "Green":
		return green.instance()
	elif carac == "Blue":
		return blue.instance()
	elif carac == "Yellow":
		return yellow.instance()
	elif carac == "Orc":
		return orc.instance()
	elif carac == "Human":
		return human.instance()
	elif carac == "Ghost":
		return ghost.instance()
	elif carac == "Elf":
		return elf.instance()
	else:
		return human.instance()

func show_match(ncolor,nclas,nrace):
	var black = Color(0,0,0,1)
	if ncolor != color:
		colorSprite.set_modulate(black)
	if nrace != race:
		raceSprite.set_modulate(black)
	if nclas != clas:
		clasSprite.set_modulate(black)

func hide_match():
	var white = Color(1,1,1,1)
	colorSprite.set_modulate(white)	
	clasSprite.set_modulate(white)
	raceSprite.set_modulate(white)

func matchFighter(ncolor,nclas,nrace):
#	print("match : "+ str(ncolor)+"/"+str(nclas)+"/"+str(nrace))
#	print("with : "+ str(color)+"/"+str(clas)+"/"+str(race))
	var co = int(color == ncolor)
	var ra = int(race == nrace)
	var cl = int(clas == nclas)
	var score = co+ra+cl
#	print("score: "+str(score))
	return(score)
