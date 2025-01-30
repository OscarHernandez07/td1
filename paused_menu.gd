extends Control

func _ready():
	# Ensure the pause menu is hidden when the game starts
	visible = false
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	visible = false  # Hide the menu after the animation finishes

func pause():
	visible = true  # Show the pause menu when pausing
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
