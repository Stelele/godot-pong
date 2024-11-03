extends CharacterBody2D

var isServed = false
var startPos = Vector2.ZERO
var ballHit: AudioStreamPlayer2D

signal scored
signal isPlaying

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = global_position
	isPlaying.emit(false)
	ballHit = get_parent().get_node("BallHit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isServed and Input.is_action_just_pressed("ui_accept"):
		serve(delta)
		isServed = true
		
	var collision = move_and_collide(velocity)
	if collision == null: return
	
	var collisionId = collision.get_collider_id()
	var objIds = getIds()
	
	if collisionId == objIds["wall1"] or collisionId == objIds["wall2"]:
		velocity = Vector2(velocity.x, -1 * velocity.y)
		ballHit.play()
		
	if collisionId == objIds["paddle1"] or collisionId == objIds["paddle2"]:
		var y = randf_range(100, 200) * delta
		var yDir = 1 if velocity.y > 0 else -1
		velocity = Vector2(-1.1 * velocity.x, yDir * y)
		ballHit.play()
		
	if collisionId == objIds["gate1"]:
		processScore(false)
		return
		
	if collisionId == objIds["gate2"]:
		processScore(true)
		return

func serve(delta: float):
	var y = randf_range(100, 200) * delta
	var x = randf_range(100, 200) * delta
	var xDir = 1 if randf() > 0.5 else -1
	var yDir = 1 if randf() > 0.5 else -1
	
	velocity = Vector2(xDir * x, yDir * y)
	isPlaying.emit(true)
	

func getIds():
	var wall1 = get_parent().get_node("Wall1").get_instance_id()
	var wall2 = get_parent().get_node("Wall2").get_instance_id()
	var paddle1 = get_parent().get_node("Paddle1").get_instance_id()
	var paddle2 = get_parent().get_node("Paddle2").get_instance_id()
	var gate1 = get_parent().get_node("Gate1").get_instance_id()
	var gate2 = get_parent().get_node("Gate2").get_instance_id()
	
	return {
		"wall1": wall1,
		"wall2": wall2,
		"paddle1": paddle1,
		"paddle2": paddle2,
		"gate1": gate1,
		"gate2": gate2
	}

func processScore(isPlayerOne: bool):
	velocity = Vector2.ZERO
	global_position = startPos
	isServed = false
	scored.emit(isPlayerOne)
	isPlaying.emit(false)
