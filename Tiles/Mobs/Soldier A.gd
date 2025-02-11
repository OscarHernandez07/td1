extends CharacterBody2D

@export var speed = 800
var soldier_health = 1 # Soldier dies after 2 hits

func death():
	var parent = get_parent().get_parent()
	  # Remove soldier from scene

	# Delay win condition check to avoid counting self
	await get_tree().process_frame  

	# Check if all soldiers are gone and the game should transition to the win screen
	if parent.get_child_count() == 0 and parent.total_soldiers_spawned >= parent.max_soldier:
		get_tree().change_scene_to_file("res://Win.tscn")  # Change to actual win scene

func _process(delta):
	if get_tree().paused:
		return  # Stop movement when paused

	# Move along the path
	get_parent().set_progress(get_parent().get_progress() + speed * delta)

	# If the soldier reaches the end
	if get_parent().get_progress_ratio() == 1:
		Game.Health -= 5
		queue_free()  # Remove soldier immediately

		# Check if the game's health has reached 0
		if Game.Health <= 0:
			Game.Health = Game.MaxHealth
			Game.Gold = Game.MaxGold
			get_tree().change_scene_to_file("res://end_scene.tscn")
