extends Node2D

@onready var player1 = $"SubViewportContainer/SubViewport/YSort/player2"
@onready var player2 = $"SubViewportContainer2/SubViewport/YSort/player2"
@onready var physicalWorld = $"SubViewportContainer/SubViewport/YSort/PhysicalWorld"
@onready var mentalWorld = $"SubViewportContainer2/SubViewport/YSort/MentalWorld"
@export var levels = 5
@export var currLevel = 1

var start_pos = Vector2(15, 15)

var p1Finished = false
var p2Finished = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.self_modulate.a = 0
	reset_player()
	physicalWorld.show_level(currLevel, levels)
	mentalWorld.show_level(currLevel, levels)

func reset_player():
	player1.get_node("AnimatedSprite2D").self_modulate.a = 1
	player2.get_node("AnimatedSprite2D").self_modulate.a = 1
	
	player1.dead = false
	player2.dead = false
	player1.moveable = true
	player2.moveable = true
	player1.position = start_pos
	player2.position = start_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if p1Finished and p2Finished:
		transferLevel()

func transferLevel():
	player1.moveable = false
	player2.moveable = false
	currLevel += 1
	p1Finished = false
	p2Finished = false
	
	$AnimationPlayer.play("fade_black")
	await get_tree().create_timer(1.5).timeout
	
	reset_player()
	mentalWorld.show_level(currLevel, levels)
	physicalWorld.show_level(currLevel, levels)
	
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(1.5).timeout 
	player1.moveable = true
	player2.moveable = true
	
	

func _on_physical_world_advance() -> void:
	#print("hi")
	p1Finished = true


func _on_mental_world_advance() -> void:
	#print("hoi")
	p2Finished = true


func _on_physical_world_retract() -> void:
	p1Finished = false


func _on_mental_world_retract() -> void:
	p2Finished = false


func _on_mental_world_hit() -> void:
	player1.dead = true
	player2.dead = true
	
	player1.get_node("AnimationPlayer").play("player_dies")
	player2.get_node("AnimationPlayer").play("player_dies")
	await get_tree().create_timer(2).timeout

	$AnimationPlayer.play("fade_black")
	await get_tree().create_timer(1.5).timeout
	reset_player()
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(1.5).timeout
