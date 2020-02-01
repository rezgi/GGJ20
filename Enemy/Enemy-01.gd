extends KinematicBody2D

var vel := Vector2.ZERO
var can_slash := true
const FLOOR_NORMAL := Vector2.UP

#export var speed := 200
#export var max_speed := 800
#export var gravity := 100
#export var jump_height := 1000
export var sword_duration := .4
export var sword_delay := 1
export var hurt_push := Vector2(-64, 0)
export var direction := 1

func _ready():
	disable_sword()
	scale.x = scale.y * direction
#	$AnimationPlayer.play("Idle")

#func _physics_process(_delta):
#	
#	# Collision detection
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		print(collision.collider.name)
#		if collision.collider.name == "Player":
#			$AnimationPlayer.play("player entered")
#			vel = hurt_push
#			vel = move_and_slide(vel, FLOOR_NORMAL)


#func activate_sword():
#	$Sword.visible = true
#	$Sword/CollisionShape2D.disabled = false
#
#	$Sword/Timer_Sword.wait_time = sword_duration
#	$Sword/Timer_Sword.start()
#
#	$Sword/Timer_Sword_delay.wait_time = sword_delay
#	$Sword/Timer_Sword_delay.start()
#	can_slash = false
#
func disable_sword():
	$Sword.visible = false
	$Sword/CollisionShape2D.disabled = true
#
#func _on_Timer_Sword_timeout():
#	disable_sword()
#
#func _on_Timer_Sword_delay_timeout():
#	can_slash = true
#
#
