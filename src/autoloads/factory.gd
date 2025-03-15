class_name Factory
extends Node2D

# Add factory methods for common scenes here. Access through the Create singleton

var tileScene: PackedScene = preload("res://map/tile.tscn")
var letterScene: PackedScene = preload("res://action/letter.tscn")
var puzzleScene: PackedScene = preload("res://action/puzzle.tscn")


func tile() -> Tile:
    var tile_node = tileScene.instantiate() as Tile
    return tile_node

func letter(character: String) -> Letter:
    if (character.length() != 1):
        push_error("A letter must be exactly one character long")
    var letter_node = letterScene.instantiate() as Letter
    letter_node.character = character

    return letter_node
