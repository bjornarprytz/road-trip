extends Node2D


@onready var action_prognosis: VBoxContainer = %ActionPrognosis
@onready var map: Map = %Map


var primed_letter: String = ""


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if primed_letter != "" and event.keycode == KEY_ENTER:
			for tile in map.get_tiles():
				if tile.letter.to_lower() == primed_letter.to_lower():
					tile.activate()
			primed_letter = ""
		elif event.keycode == KEY_ESCAPE:
			primed_letter = ""
		else:
			var key_string = OS.get_keycode_string(event.keycode)
			if (key_string.length() == 1):
				primed_letter = key_string
				print("Primed %s" % primed_letter)
