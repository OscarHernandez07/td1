extends CharacterBody2D


var target 
var Speed = 1200
var pathName = ""
var bulletDamage

func _physics_process(_delta):
	var pathSpawnerNode = get_tree().get_root().get_node("Main/PathSpawner")
	
	for i in range(pathSpawnerNode.get_child_count()):
		#print(pathSpawnerNode.get_child(i).name)
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position;
			#hackkk
			
			if (target == null):
				print("target nil")
				return;
			
	velocity = global_position.direction_to(target) * Speed
	
	look_at(target)
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if "Soldier A" in body.name:
		body.Health -= bulletDamage
		queue_free()
