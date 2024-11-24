extends Node2D
signal advance
signal retract
signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	$"Template Level/Obstacles".set_enabled(false)
	$"Template Level/Spikes/CollisionPolygon2D".set_disabled(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_level(currLevel, levels):
	for i in range(1, 6):
		var level = get_children()[i-1]
		if i == currLevel:
			level.visible = true
			level.get_child(1).set_enabled(true)
			if len(level.get_children()) == 3:
				var spike = level.get_child(2)
				for y in spike.get_children():
					if y is CollisionPolygon2D:
						y.set_disabled(false)
		else:
			level.visible = false
			level.get_child(1).set_enabled(false)
			if len(level.get_children()) == 3:
				var spike = level.get_child(2)
				for y in spike.get_children():
					if y is CollisionPolygon2D:
						y.set_disabled(true)

func _on_fire_advance() -> void:
	advance.emit()


func _on_fire_retract() -> void:
	retract.emit()


func _on_spikes_body_entered(body: Node2D) -> void:
	if body.name == "player2":
		hit.emit()
