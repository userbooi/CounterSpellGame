extends Node2D

@onready var p1Camera = $player/Camera2D
@onready var p2Camera = $player2/Camera2D
@onready var player1 = $Player1
@onready var player2 = $Player2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport1 = $SubViewportContainer/SubViewport 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
