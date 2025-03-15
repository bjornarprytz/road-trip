class_name Letter
extends Control

var character: String
@onready var letter: RichTextLabel = %Text

var _forecasting: bool = false
var _completed: bool = false

func _ready() -> void:
	letter.text = character.to_upper()

func forecast(on: bool):
	_forecasting = on
	if on:
		print("Forecasting: %s" % character)
		letter.modulate = Color.BLUE_VIOLET
	else:
		letter.modulate = Color.WHITE
	

func complete():
	_forecasting = false
	_completed = true
	
	letter.modulate = Color.GREEN
	
	print("Completed letter %s" % character)
