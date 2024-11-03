extends CharacterBody2D

const SPEED = 300.0
var startPos: Vector2

func _ready():
	startPos = global_position

func _physics_process(delta):
	var direction = Input.get_axis("p1_up", "p1_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_ball_scored(isPlayer1: bool):
	global_position = startPos
