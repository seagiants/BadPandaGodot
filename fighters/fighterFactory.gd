extends Node

#const human = preload("fighterSprites/Human.tscn")
#const orc = preload("fighterSprites/Orc.tscn")
#const sword = preload("fighterSprites/Sword.tscn")
#const bow = preload("fighterSprites/Bow.tscn")
#const red = preload("fighterSprites/Red.tscn")
#const blue = preload("fighterSprites/Blue.tscn")
#const green = preload("fighterSprites/Green.tscn")
#const yellow = preload("fighterSprites/Yellow.tscn")
const Fighter = preload("fighter.gd")

var fighterPool = []

#func newFighter(color,clas,race):
#	var fighter = Fighter.new(color,clas,race)
#	fighter.init(color,clas,race)
#	return fighter

func _init():
	var i = 0
	for col in ["Red","Blue","Green","Yellow"]:
		for rac in ["Orc","Human","Elf","Ghost"]:
			for cla in ["Sword","Bow","Shield","Wand"]:
#	for col in ["Red","Blue"]:
#		for rac in ["Orc","Human"]:
#			for cla in ["Sword","Bow"]:	
				var fighter = Fighter.new(col,cla,rac)
				fighterPool.append(fighter)
				i=i+1
	randomize()
	fighterPool.shuffle()

func draw():
	if fighterPool.size()>0:
		var current = fighterPool[0]
		fighterPool.remove(0)
		return current
	else:
		print("Plus assez de fighter")
		return null

