extends Node2D


@onready var action_prognosis: VBoxContainer = %ActionPrognosis
@onready var map: Map = %Map


var primed_letter: String = ""

func _ready() -> void:
	for tile in map.get_tiles():
		tile.puzzle.complete.connect(_on_puzzle_completed.bind(tile))
		
func _on_puzzle_completed(puzzle: Puzzle, tile: Tile):
	tile.activate()
	print("Activiated %s" % tile.coordinates)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if primed_letter != "" and event.keycode == KEY_ENTER:
			for tile in map.get_tiles():
				tile.puzzle.commit_letter(primed_letter)
			primed_letter = ""
		elif event.keycode == KEY_ESCAPE:
			primed_letter = ""
		else:
			var key_string = OS.get_keycode_string(event.keycode)
			if (key_string.length() == 1):
				primed_letter = key_string
				print("Primed %s" % primed_letter)
				for tile in map.get_tiles():
					tile.puzzle.forecast_letter(primed_letter)
			
