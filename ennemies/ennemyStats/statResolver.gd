extends Node

signal score_modified(stat,new_score)

func resolve_stat(stats,stat_name,score):
	var f = funcref(self,"resolve_"+stat_name)
	print(stat_name)
	return f.call_func(score,stats)
	
func resolve_protection(score,color):
	if score.color.type == color and score.color.value != 0:
		var new_score = score
		new_score.color.value = 0
		emit_signal("score_modified","Protection contre "+color,new_score)
		return new_score
	else:
		return score
	
func resolve_protred(score,_stats):
	return resolve_protection(score,"Red")

func resolve_protblue(score,_stats):
	return resolve_protection(score,"Blue")

func resolve_armored(score,stats):
	if scoreResolver.get_score_int(score) < stats.hp :
		var new_score = score
		for i in score:
			new_score[i].value = 0		
		emit_signal("score_modified","Armure",new_score)
		return new_score
	else:
		return score
