extends Node2D
signal advance
signal retract

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pass # Replace with function body.
	$"TemplateLevel/Trees".set_enabled(false)
	#$"TemplateLevel/"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_level(currLevel, levels):
	for i in range(1, 6):
		var level = get_children()[i-1]
		if i == currLevel:
			level.visible = true
			level.get_child(1).set_enabled(true)
		else:
			level.visible = false
			level.get_child(1).set_enabled(false)


func _on_fire_advance() -> void:
	advance.emit()


func _on_fire_retract() -> void:
	retract.emit()
