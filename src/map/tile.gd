class_name Tile
extends Node2D

signal onHovered(tile: Tile)
signal onClicked(tile: Tile)

var map: Map

var actions: Array[TileAction] = []
var state: String

@onready var shape: RegularPolygon:
	get:
		return $Shape

@onready var size: float:
	get:
		return shape.size
	set(value):
		shape.size = value

var coordinates: Map.Coordinates:
	set(value):
		coordinates = value

var isHovered: bool
@onready var baseModulate: Color = self.modulate
@onready var puzzle: Puzzle = %Puzzle

func activate() -> void:
	print("Activating %s" % coordinates.get_key())
	for a in actions:
		self.apply(a as TileAction)
	actions.clear()

func apply(action: TileAction):
	print("%s: %s" % [coordinates, action.description])
	state = action.targetState
	baseModulate = action.color

func get_neighbours() -> Array[Tile]:
	var neighbours: Array[Tile] = []

	for nCoord in coordinates.get_neighbours():
		var n = map.get_tile(nCoord)

		if (n != null):
			neighbours.push_back(n)

	return neighbours

func get_relative_tile(displacement: Vector2i) -> Tile:
	var targetCoords = coordinates.add_vec(displacement)
	return map.get_tile(targetCoords)

func get_rotated_tile(rotationSteps: int) -> Tile:
	var rotatedCoords = coordinates.get_rotated(rotationSteps)
	return map.get_tile(rotatedCoords)

func _physics_process(_delta: float) -> void:
	if isHovered:
		shape.modulate = baseModulate * (pingpong(Time.get_ticks_msec() / 1000.0, 1.0) + .5)
	else:
		shape.modulate = baseModulate

func _ready() -> void:
	assert(map != null)
	scale = Vector2.ONE * .2
	create_tween().tween_property(self, 'scale', Vector2.ONE, .2)
	shape.clicked.connect(_on_tile_pressed)
	shape.hovered.connect(_on_tile_hovered)

	puzzle.set_word(Utility.random_word(3))

func _on_tile_pressed() -> void:
	onClicked.emit(self)

func _on_tile_hovered(state: bool) -> void:
	if (state):
		onHovered.emit(self)
	
	isHovered = state
