extends CharacterBody2D


@export var speed = 200
#Prob the health for soldier
var Health = 10


# Function to transition to the ending scene
func end_game():
	get_tree().change_scene_to_file("res://end_scene.tscn")

func death():
	get_parent().get_parent().queue_free()

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)

	if get_parent().get_progress_ratio() == 1:
		Game.Health -= 2
		death()

		# Check if the game's health has reached 0
		if Game.Health <= 0:
			Game.Health = Game.MaxHealth
			Game.Gold = Game.MaxGold
			end_game()


