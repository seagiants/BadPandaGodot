extends Node

var _ennemyLib = {
	"SimpleBlue":{
		"hp": 5,
		"protblue": "Les combos bleus sont sans effets"
	},
	"SimpleRed":{
		"hp": 5,
		"protred": "Les combos rouges sont sans effets"
	},
	"Knight":{
		"hp": 4,
		"armored": "Prévient les dégats < HP"
	}
}

func get_ennemy_template(name):
	if name in _ennemyLib :
		return _ennemyLib[name]
	else :
		print("ennemyLib : Ennemi inconnu : "+name)
		return null
