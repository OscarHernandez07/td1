extends CharacterBody2D

@export var speed = 1000
var Health = 100

# Function to transition to the ending scene
func end_game():
	var ending_scene = preload("res://end_scene.tscn") # Replace with your actual ending scene path
	get_tree().change_scene_to_file(ending_scene)

func death():
	get_parent().get_parent().queue_free()

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)

	if get_parent().get_progress_ratio() == 1:
		Game.Health -= 1
		death()

		# Check if the game's health has reached 0
		if Game.Health <= 0:
			end_game()

	if Health <= 0:
		Game.Gold += 1
		death()
