static func get_phase_text(phase):
	match phase :
		"pick":
			return "Choisis un combattant et place le sur la map"
		"keep":
			return "Choisis un combattant à conserver ou finis le tour."
