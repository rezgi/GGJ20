extends KinematicBody2D

var vel := Vector2.ZERO
var can_slash := true
var can_be_hurt := true
var direction := 1
var player_hp := 5

const FLOOR_NORMAL := Vector2.UP

export var speed := 200
export var max_speed := 800
export var gravity := 100
export var jump_height := 1000
export var sword_duration := .4
export var sword_delay := .6
export var hurt_push := Vector2(-1000, -400)
export var hurt_delay := .6

func _ready():
	disable_sword()

func _physics_process(_delta):
	vel.y += gravity
	
	# Inputs
	if Input.is_action_pressed("ui_right"):
		vel.x = min(vel.x + speed, max_speed)
		direction = 1
		scale.x = scale.y * direction
	elif Input.is_action_pressed("ui_left"):
		vel.x = max(vel.x - speed, -max_speed)
		direction = -1
		scale.x = scale.y * direction
	else:
		vel.x = 0
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		vel.y = -jump_height
	
	# Movement
	vel.x = lerp(vel.x, 0, .1)
	vel = move_and_slide(vel, FLOOR_NORMAL)

	# Slash
	if Input.is_action_just_pressed("ui_action"):
		if can_slash: activate_sword()
	
	# Collision detection
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision and can_be_hurt:
			if collision.collider.name == "Spike-01": hurt()
			if collision.collider.name == "Enemy-01": hurt()


func activate_sword():
	$Sword.visible = true
	$Sword/CollisionShape2D.disabled = false
	
	$Sword/Timer_Sword.wait_time = sword_duration
	$Sword/Timer_Sword.start()
	
	$Sword/Timer_Sword_delay.wait_time = sword_delay
	$Sword/Timer_Sword_delay.start()
	can_slash = false

func disable_sword():
	$Sword.visible = false
	$Sword/CollisionShape2D.disabled = true

func _on_Timer_Sword_timeout():
	disable_sword()

func _on_Timer_Sword_delay_timeout():
	can_slash = true

func _on_Sword_body_entered(body):
	if body.name == "Enemy-01":
		hurt()

func _on_Timer_Hurt_Delay_timeout():
	can_be_hurt = true

func hurt():
	can_be_hurt = false
	$Timer_Hurt_Delay.wait_time = hurt_delay
	$Timer_Hurt_Delay.start()
	
	$AnimationPlayer.play("Hurt")
	vel = hurt_push * direction
	vel = move_and_slide(vel, FLOOR_NORMAL)
	
	player_hp -= 1
	if player_hp == 0: die()

func die():
	queue_free()
	# Game over screen




func _on_enemy_attack_area_entered(area):
#	if area.name == "Enemy_sword":
#		hurt()
#		print(area.name)
	pass
