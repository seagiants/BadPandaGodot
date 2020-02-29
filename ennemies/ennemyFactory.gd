extends Node

const Ennemy = preload("ennemy.gd")
var ennemyPool = []

func _init(ennemies,shuffle = true):
	for ennemy_name in ennemies.keys():
		for _i in range(ennemies[ennemy_name]):
				print("ennemyFactory : Création "+ennemy_name)
				var stats = EnnemyLib.get_ennemy_template(ennemy_name)
				var ennemy = Ennemy.new(ennemy_name,stats)
#				print(ennemy.stats)
				ennemyPool.append(ennemy)
	if shuffle:
		randomize()
		ennemyPool.shuffle()

func spawn():
	return ennemyPool.pop_front()

func count():
	return ennemyPool.size()
