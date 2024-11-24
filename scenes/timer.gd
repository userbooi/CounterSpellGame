extends Control
signal start_game


var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setUp()
	
func setUp():
	$Title1.self_modulate.a = 0
	$Title2.self_modulate.a = 0
	$Title1.position = Vector2(-386, 156)
	$Title2.position = Vector2(-388.5, 156)
	$startbutton.set_disabled(true)
	$startbutton.visible = false
	$counterLabel.visible = false
	$promptText.visible = false
	$winText.self_modulate.a = 0
	$promptText.self_modulate.a = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$counterLabel.text = str(round(counter * 10) / 10)


func _on_timer_timeout() -> void:
	counter += 0.1


func _on_startbutton_pressed() -> void:
	$counterLabel.visible = true
	$Title1.visible = false
	$Title2.visible = false
	$startbutton.visible = false
	$startbutton.set_disabled(true)
	
	$Timer.start()
	
	start_game.emit()
