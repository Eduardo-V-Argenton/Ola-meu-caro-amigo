extends CharacterBody2D

const MOVE_SPEED = 45


@onready var animation := $animsp as AnimatedSprite2D
@onready var meow := $meow as AudioStreamPlayer

func _ready():
	animation.play("idle front")
	
func _physics_process(_delta):
	if not Global.is_laying_down:
		if Global.wait:
			if animation.frame != 7:
				return 0
			Global.wait = false
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		if input_direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]:
			Global.last_direction = input_direction;
	
		
		elif input_direction != Vector2.ZERO:
			input_direction = Global.last_direction
		
		update_animation_parameters(input_direction)
	
		velocity = input_direction * MOVE_SPEED
	
		move_and_slide()
	
func _input(ev):
	if Input.is_action_just_pressed("meow"):
		meow.play()
	var position = get_position()
	if position.x < -216 and position.x > -231 and position.y < -523 and position.y > -548:
		if Input.is_action_just_pressed("lay down"):
			if not Global.is_laying_down:
				Global.is_laying_down = true
				animation.play("laying down front")
				meow.play()
			else:
				Global.is_laying_down = false
				animation.play("laying up front")
				Global.wait = true
	
	
func update_animation_parameters(move_input : Vector2):
	
	if move_input == Vector2.RIGHT :
		animation.play("walking right")
	elif move_input == Vector2.LEFT :
		animation.play("walking left")
	elif move_input == Vector2.UP :
		animation.play("walking back")
	elif move_input == Vector2.DOWN :
		animation.play("walking front")
	else:
		if Global.last_direction == Vector2.LEFT :
			animation.play("idle left")
		elif Global.last_direction == Vector2.RIGHT :
			animation.play("idle right")
		elif Global.last_direction == Vector2.UP:
			animation.play("idle back")
		else:
			animation.play("idle front")
		
		
