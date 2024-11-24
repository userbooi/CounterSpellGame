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
var won = false
var play_sound = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	
func start():
	play_sound = false
	$ColorRect.self_modulate.a = 1
	player1.position = start_pos
	player2.position = start_pos
	physicalWorld.show_level(currLevel, levels)
	mentalWorld.show_level(currLevel, levels)
	openingCutscene();
	
func openingCutscene():
	$UI/AnimationPlayer.play("Opening")
	await get_tree().create_timer(2.5).timeout
	
	$UI/startbutton.set_disabled(false)
	$UI/startbutton.visible = true
	
	play_sound = true
	$AnimationPlayer.play("Opening")
	await get_tree().create_timer(2.5).timeout
	

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
	if play_sound:
		if !$ambiance1.is_playing():
			$ambiance1.play()
		if !$ambiance2.is_playing():
			$ambiance2.play()
	else:
		$ambiance1.stop()
		$ambiance2.stop()
	if p1Finished and p2Finished:
		transferLevel()
	if won and Input.is_action_just_pressed("reload"):
		currLevel = 1
		$UI.setUp()
		start()

func transferLevel():
	player1.moveable = false
	player2.moveable = false
	currLevel += 1
	p1Finished = false
	p2Finished = false
	
	$AnimationPlayer.play("fade_black")
	await get_tree().create_timer(1.5).timeout
	
	if currLevel <= levels:
		reset_player()
		mentalWorld.show_level(currLevel, levels)
		physicalWorld.show_level(currLevel, levels)
	
		$AnimationPlayer.play("fade_out")
		await get_tree().create_timer(1.5).timeout 
		player1.moveable = true
		player2.moveable = true
	else:
		$UI/Timer.stop()
		$UI/AnimationPlayer.play("winTextAnim")
		await get_tree().create_timer(1).timeout 
		won = true
	
	

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


func _on_ui_start_game() -> void:
	reset_player()
