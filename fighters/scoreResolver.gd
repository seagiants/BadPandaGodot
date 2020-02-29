extends Node

func get_score_int(score):
	var score_int = 0
	for i in score:
		if "value" in score[i] :
			score_int += score[i].value
	return score_int
