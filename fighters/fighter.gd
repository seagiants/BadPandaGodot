extends Node2D

const human = preload("fighterSprites/Human.tscn")
const orc = preload("fighterSprites/Orc.tscn")
const elf = preload("fighterSprites/Elf.tscn")
const ghost = preload("fighterSprites/Ghost.tscn")
const sword = preload("fighterSprites/Sword.tscn")
const bow = preload("fighterSprites/Bow.tscn")
const wand = preload("fighterSprites/Wand.tscn")
const shield = preload("fighterSprites/Shield.tscn")
#const red = preload("fighterSprites/Red.tscn")
#const blue = preload("fighterSprites/Blue.tscn")
#const green = preload("fighterSprites/Green.tscn")
#const yellow = preload("fighterSprites/Yellow.tscn")
const panelTemplate = preload("fighterSprites/FighterPanel.tscn")
const colorPattern = {
	"Blue": Color(0,0,1,1),
	"Green": Color(0,1,0,1),
	"Red": Color(1,0,0,1),
	"Yellow": Color(1,1,0,1)
}
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
#	colorSprite = get_sprite(ncolor)
#	add_child(colorSprite)
	colorSprite = get_panel(ncolor)
	add_child(colorSprite)
	raceSprite = get_sprite(nrace)
	add_child(raceSprite)
	raceSprite.set_position(Vector2(10,14))
	clasSprite = get_sprite(nclas)
	add_child(clasSprite)
	clasSprite.set_position(Vector2(26,14))
	var clickZone = Control.new()
	clickZone.set_size(Vector2(64,64))
	add_child(clickZone)
	clickZone.connect("gui_input",self,"on_click")
	clickZone.set_mouse_filter(1)
	
func _ready():
#	get_panel("Blue","Bo")
	pass # Replace with function body.
	

func on_click(event):
	if onMap == 1:
		return
	if (event.is_pressed() and "button_index" in event and event.button_index == BUTTON_LEFT):
		emit_signal("fighter_selected",self,self)

#Récupérer les style_box semble buggé. On récupère un StyleBoxTexture au lieu d'une Flat, impossible d'en définir la couleur...
static func get_panel(ncolor):
	var ocolor = colorPattern[ncolor]
	var panel = Panel.new()
	panel.set_size(Vector2(32,32))
	var style = StyleBoxFlat.new()
	style.set_bg_color(ocolor)
	style.set_corner_radius_all(4)
	panel.set("custom_styles/panel",style)
	return panel

func set_panel(npanel):
	colorSprite.queue_free()
	colorSprite = npanel
	var cont = npanel.get_parent()
	cont.remove_child(npanel)   
	cont.queue_free()
	add_child(npanel)
	move_child(npanel,0)
	
func get_sprite(carac):
	if carac == "Sword":
		return sword.instance()
	elif carac == "Bow":
		return bow.instance()
	elif carac == "Wand":
		return wand.instance()
	elif carac == "Shield":
		return shield.instance()
#	elif carac == "Red":
#		return red.instance()
#	elif carac == "Green":
#		return green.instance()
#	elif carac == "Blue":
#		return blue.instance()
#	elif carac == "Yellow":
#		return yellow.instance()
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
	var score = {}
	score.color ={
		"type": color,
		"value": int(color == ncolor)
		}
	score.clas ={
		"type": clas,
		"value": int(clas == nclas)
		}
	score.race ={
		"type": race,
		"value": int(race == nrace)
		}	
	return(score)
