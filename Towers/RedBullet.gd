extends CharacterBody2D

var target
var Speed = 2000
var pathName = ""
var bulletDamage = 1
var soldier_health = 2

func _physics_process(_delta):
	var pathSpawnerNode = get_tree().get_root().get_node("Main/PathSpawner")
	
	for i in range(pathSpawnerNode.get_child_count()):
		var child_node = pathSpawnerNode.get_child(i)
   	 
		if child_node.name == pathName:
			# Make sure the target node exists and has a valid position
			var target_node = child_node.get_child(0).get_child(0)
	   	 
			if target_node:
				target = target_node.global_position
				 #Check if the target position is valid (not NaN or infinite)
				if target == Vector2():
					print("Target position is invalid (empty Vector2).")
					return
			else:
				print("Target node does not exist.")
				return
	   	 
			 #If target is still invalid or null after these checks, exit
			if target == null:
				print("Target is null!")
				return

			# Continue with movement
			velocity = global_position.direction_to(target) * Speed
			look_at(target)
			move_and_slide()

func _on_area_2d_body_entered(body):
	if "Soldier A" in body.name:
		#print(soldier_health)
		soldier_health -= bulletDamage
		
		if soldier_health <= 0:
			body.get_parent().get_parent().queue_free()
		
		queue_free()
		

	
