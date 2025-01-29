extends Node2D


@onready var path = preload("res://Tiles/Mobs/Stage2P1.tscn")
@onready var path2d = preload("res://Tiles/Mobs/Stage2P2.tscn")

func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)
	
func _on_timer_timeout2():
	var tempPath2 = path2d.instantiate()
	add_child(tempPath2)
	
