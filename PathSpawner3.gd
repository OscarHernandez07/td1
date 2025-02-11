extends Node2D


@onready var path = preload("res://Tiles/Mobs/Stage3P1.tscn")
@onready var path2 = preload("res://Tiles/Mobs/Stage3P2.tscn")
@onready var path3 = preload("res://Tiles/Mobs/Stage3P3.tscn")

func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)
	
func _on_timer_timeout2():
	var tempPath2 = path2.instantiate()
	add_child(tempPath2)
	
func _on_timer_timeout3():
	var tempPath3 = path3.instantiate()
	add_child(tempPath3)
