extends Node2D

@onready var p1Camera = $player/Camera2D
@onready var p2Camera = $player2/Camera2D
@onready var player1 = $Player1
@onready var player2 = $Player2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var viewport1 = Viewport.new()
	#viewport1.size = Vector2(960, 1080)
	#p1Camera.current = true
	#p1Camera.get_viewport().add_child(viewport1)
#
	#var viewport2 = Viewport.new()
	#viewport2.size = Vector2(960, 1080)
	#p2Camera.current = true
	#p2Camera.get_viewport().add_child(viewport2)
#
	## Split screen layout
	#viewport1.position = Vector2(0, 0)
	#viewport2.position = Vector2(960, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
