extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

#animations
func _process(_delta):
	
	
	if is_on_wall():
		_animated_sprite.play("slide")
	elif not is_on_floor():
		_animated_sprite.play("fall")
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("runright")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("runleft")
	elif Input.is_action_just_pressed("ui_up"):
		_animated_sprite.play("jump")
	else:
		_animated_sprite.play("idle")


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpsLeft = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#wall jump
	if is_on_wall():
		jumpsLeft=1
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AudioStreamPlayer2D.play()
		velocity.y = JUMP_VELOCITY
		jumpsLeft=1
	elif Input.is_action_just_pressed("ui_accept") and !is_on_floor() and jumpsLeft>0:
		jumpsLeft=0
		$AudioStreamPlayer2D.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
