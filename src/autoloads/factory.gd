class_name Factory
extends Node2D

# Add factory methods for common scenes here. Access through the Create singleton

var tileScene: PackedScene = preload("res://map/tile.tscn")


func tile() -> Tile:
    var tile_node = tileScene.instantiate() as Tile
    return tile_node