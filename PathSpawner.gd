extends Node2D

@onready var path = preload("res://Tiles/Mobs/Stage1.tscn")
@onready var timer = $Timer

var soldier_count = 0
var total_soldiers_spawned = 0
var max_soldier = 5
var group_size = 1   # Soldiers per spawn

func _on_timer_timeout():
	if total_soldiers_spawned < max_soldier:
		spawn_group(group_size)
	else:
		timer.stop()  # Stop spawning once all soldiers are created

func spawn_group(num):
	for i in range(num):
		if total_soldiers_spawned < max_soldier:
			var tempPath = path.instantiate()
			add_child(tempPath)
			total_soldiers_spawned += 1  # Track total soldiers spawned
