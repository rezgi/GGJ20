extends KinematicBody2D

var vel := Vector2.ZERO
var enemy_hp := 3
var nbr_attacks := 1
var can_attack := false

const FLOOR_NORMAL := Vector2.UP

export var sword_duration := .4
export var sword_delay := 1
export var hurt_push := Vector2(-1000, 0)
export var hurt_delay := .6
export var direction := 1

func _ready():
	disable_sword()
	scale.x = scale.y * direction

func activate_sword():
	$Enemy_Sword.visible = true
	$Enemy_Sword/CollisionShape2D.set_deferred("disabled", false)

	$Enemy_Sword/Timer_Sword.wait_time = sword_duration
	$Enemy_Sword/Timer_Sword.start()
	
	nbr_attacks += 1

func disable_sword():
	$Enemy_Sword.visible = false
	$Enemy_Sword/CollisionShape2D.disabled = true

func _on_Timer_Sword_timeout():
	disable_sword()

# player sword detection
func _on_Area2D_area_entered(area):
	if nbr_attacks == 1 && can_attack:
		activate_sword()
	if area.name == "Sword": hurt()

func hurt():
	$timer_attack.start()
	$AnimationPlayer.play("Hurt")
	vel = hurt_push * direction
	vel = move_and_slide(vel, FLOOR_NORMAL)
	
	enemy_hp -= 1
	if enemy_hp == 0: die()

func die():
	queue_free()


func _on_timer_attack_timeout():
	can_attack = true
