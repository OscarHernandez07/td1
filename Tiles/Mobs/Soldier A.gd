extends CharacterBody2D

@export var speed = 400
var Health = 100  # Soldier health

func end_game():
	get_tree().change_scene_to_file("res://end_scene.tscn")

func win_game():
	get_tree().change_scene_to_file("res://Win.tscn")  # Change to actual win scene path

func death():
	var parent = get_parent().get_parent()
	queue_free()  # Remove soldier from scene

	# Delay the check to ensure it counts after removal
	await get_tree().process_frame

	# Check if all soldiers are gone
	if parent.get_child_count() == 0 and parent.total_soldiers_spawned >= parent.max_soldier:
		win_game()

func take_damage(damage):
	Health -= damage
	if Health <= 0:
		death()

func _process(delta):
	if get_tree().paused:
		return  # Stop movement when paused

	get_parent().set_progress(get_parent().get_progress() + speed * delta)

	# If the soldier reaches the end
	if get_parent().get_progress_ratio() == 1:
		Game.Health -= 1
		death()

		# Check if the game's health has reached 0
		if Game.Health <= 0:
			Game.Health = Game.MaxHealth
			Game.Gold = Game.MaxGold
			end_game()

