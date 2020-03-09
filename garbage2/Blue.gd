extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	var style = self.get_stylebox("custom_styles/panel","StyleBoxFlat")
	var test = StyleBoxFlat.new()
	test.set_bg_color(Color(0.5,0.5,0,1))
	self.set("custom_styles/panel",test)
