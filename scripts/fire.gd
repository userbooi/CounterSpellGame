extends Node2D
signal advance
signal retract

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player2":
		advance.emit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player2":
		retract.emit()
