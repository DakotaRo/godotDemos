extends CharacterBody2D

var speed = 40
var playerChase = false
var player = null

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if playerChase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("walk")
		if(player.position.x - position.x)<0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		
func _on_detection_area_body_entered(body):
	player = body
	playerChase = true
	
func _on_detection_area_body_exited(body):
	player = null
	playerChase = false
	
