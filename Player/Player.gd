extends KinematicBody2D

var vel := Vector2.ZERO
var can_slash := true
const FLOOR_NORMAL := Vector2.UP

export var speed := 200
export var max_speed := 800
export var gravity := 100
export var jump_height := 1000
export var sword_duration := .4
export var sword_delay := .6

func _ready():
	disable_sword()

func _physics_process(delta):
	vel.y += gravity
	if Input.is_action_pressed("ui_right"):
		vel.x = min(vel.x + speed, max_speed)
		scale.x = scale.y * 1
	elif Input.is_action_pressed("ui_left"):
		vel.x = max(vel.x - speed, -max_speed)
		scale.x = scale.y * -1
	else:
		vel.x = 0
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		vel.y = -jump_height
	
	vel.x = lerp(vel.x, 0, .1)
	vel = move_and_slide(vel, FLOOR_NORMAL)

	if Input.is_action_just_pressed("ui_action"):
		if can_slash:
			activate_sword()

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
