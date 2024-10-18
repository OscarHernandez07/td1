extends Panel


@onready var tower = preload("res://Towers/RedBulletTower.tscn")
var currTile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#Left click down
		add_child(tempTower)
		
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		
		tempTower.scale = Vector2(0.32,0.32)
		
		
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
	elif event is InputEventMouseMotion and event.button_mask == 1:
		#left click down drag
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
		
			var mapPath = get_tree().get_root().get_node("Main/TileMap")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(0, tile, false)
			
			if (currTile == Vector2i(4,5)):
				get_child(1).get_node("Area").modulate = Color(0, 255, 0, 0.4)
			else: 
				get_child(1).get_node("Area").modulate = Color(255.0, 0, 0, 0.4   )
				
	elif event is InputEventMouseButton and event.button_mask == 0:
		#left click up
		if event.global_position.x >= 5000:
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()  
			if currTile == Vector2i(4,5):
				var path = get_tree().get_root().get_node("Main/Towers")
						
				path.add_child(tempTower)
				# this sucks ont he mac
				#tempTower.position = event.global_position
				# this is legit
				tempTower.position = get_viewport().get_mouse_position()
				tempTower.get_node("Area").hide()
			#print(event)
			#print(event.global_position)
			#print(get_viewport().get_mouse_position())
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
		
	
	
	
	
	
