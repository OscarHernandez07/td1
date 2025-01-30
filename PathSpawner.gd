extends Node2D



@onready var path = preload("res://Tiles/Mobs/Stage1.tscn")

var soldier_count = 0
var max_soldier = 50

func _on_timer_timeout():
	if soldier_count < max_soldier:
		var tempPath = path.instantiate()
		add_child(tempPath)
		add_child(tempPath)
		soldier_count += 2
	else:
		print(" ")
