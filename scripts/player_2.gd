extends CharacterBody2D


const SPEED = 150.0

var facing = "s"

func _process(delta: float) -> void:
	print(facing)
	if velocity == Vector2.ZERO:
		if facing == "s":
			$AnimatedSprite2D.play("playerIdleS")
		elif facing == "n":
			$AnimatedSprite2D.play("playerIdleN")
		elif facing == "e":
			$AnimatedSprite2D.play("playerIdleE")
		else:
			$AnimatedSprite2D.play("playerIdleW")
	else:
		if facing == "s":
			$AnimatedSprite2D.play("playerWalkS")
		elif facing == "n":
			$AnimatedSprite2D.play("playerWalkN")
		elif facing == "e":
			$AnimatedSprite2D.play("playerWalkE")
		else:
			$AnimatedSprite2D.play("playerWalkW")

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	var vertical := Input.get_axis("top", "bottom")
	if direction:
		if direction < 0:
			facing = "w"
		elif direction > 0:
			facing = "e"
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if vertical:
		if velocity.x == 0:
			if vertical < 0:
				facing = "n"
			elif vertical > 0:
				facing = "s"
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
