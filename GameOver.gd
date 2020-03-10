extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel2.set_text("Score : "+str(GameState.final_score))


func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
