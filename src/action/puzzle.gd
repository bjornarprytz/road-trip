class_name Puzzle
extends GridContainer

signal complete(puzzle: Puzzle)

var word: String

var current_letter: Letter:
	get:
		return get_child(_current_index) as Letter

var _current_index: int = 0
var _is_completed = false

func forecast_letter(character: String):
	assert(character.length() == 1)
	
	if _is_completed:
		return
	
	if current_letter.character.to_upper() == character.to_upper():
		current_letter.forecast(true)
	else:
		current_letter.forecast(false)

func commit_letter(character: String):
	assert(character.length() == 1)
	
	if _is_completed:
		return
	
	if current_letter.character.to_upper() == character.to_upper():
		current_letter.complete()
		_current_index += 1
		if _current_index == word.length():
			print("Word completed!")
			_is_completed = true
			complete.emit(self)
	else:
		current_letter.forecast(false)

func set_word(new_word: String):
	assert(new_word.length() > 0, "Puzzle must contain a word")
	for child in get_children():
		child.queue_free()
	_is_completed = false
	word = new_word
	for character in new_word:
		var letter = Create.letter(character)
		add_child(letter)
