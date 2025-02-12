extends StaticBody2D

var Bullet = preload("res://Towers/RedBullet.tscn")
var bulletDamage = 10000
var pathName
var currTargets = []
var curr

var reload = 0
var range = 400

@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var startShooting = false

func _process(_delta):
	get_node("Upgrade/ProgressBar").global_position = self.position + Vector2(-64, -81)
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		if timer.is_stopped():
			timer.start()
	else:
		for i in range(get_node("BulletContainer").get_child_count()): # Fixed loop
			get_node("BulletContainer").get_child(i).queue_free()
	update_powers()

func Shoot():
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position

func _on_tower_body_entered(body):
	if "Soldier A" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		
		for i in currTargets:
			if "Soldier" in i.name:
				tempArray.append(i)
			
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
					
		curr = currTarget
		if currTarget:
			pathName = currTarget.get_parent().name

func _on_towers_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Main/Towers")
		for i in range(towerPath.get_child_count()):  # Fixed loop
			var other_tower = towerPath.get_child(i)
			if other_tower.name != self.name:
				var upgrade_node = other_tower.get_node("Upgrade/Upgrade")
				if upgrade_node:
					upgrade_node.hide()
		
		var upgrade_node = get_node("Upgrade/Upgrade")
		if upgrade_node:
			upgrade_node.visible = !upgrade_node.visible
			upgrade_node.global_position = self.position + Vector2(-572, 81)

func _on_timer_timeout():
	Shoot()

func _on_range_pressed():
	range += 20

func _on_attack_speed_pressed():
	if reload <= 4.5:
		reload += 1
	timer.wait_time >= 5 - reload

func _on_power_pressed():
	bulletDamage += 5
	update_powers()

func update_powers():
	get_node("Upgrade/Upgrade/HBoxContainer/Range/Label").text = str(range)
	get_node("Upgrade/Upgrade/HBoxContainer/AttackSpeed/Label").text = str(5 - reload)
	get_node("Upgrade/Upgrade/HBoxContainer/Power/Label").text = str(bulletDamage)
	
	get_node("Tower/CollisionShape2D").shape.radius = range

func _on_range_mouse_entered():
	get_node("Tower/CollisionShape2D").show()

func _on_range_mouse_exited():
	get_node("Tower/CollisionShape2D").hide()

