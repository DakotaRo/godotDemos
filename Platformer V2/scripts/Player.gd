extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var _animated_sprite = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = true

func _process(delta):
	if is_on_wall():
		_animated_sprite.play("slide")
		$AnimatedSprite2D.flip_h = true
	elif not is_on_floor():
		_animated_sprite.play("fall")
	elif Input.is_action_pressed("ui_right"):
		dir = true
		$AnimatedSprite2D.flip_h = false
		_animated_sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		dir = false
		$AnimatedSprite2D.flip_h = true
		_animated_sprite.play("run")
	elif Input.is_action_just_pressed("ui_up"):
		_animated_sprite.play("jump")
	else:
		_animated_sprite.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	if Input.is_action_just_pressed("ui_accept") and is_on_wall():
		velocity.y = JUMP_VELOCITY 
		$AnimatedSprite2D.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	move_and_slide()
