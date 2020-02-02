extends KinematicBody2D

var vel := Vector2.ZERO
var enemy_hp := 3
var can_attack := true

const FLOOR_NORMAL := Vector2.UP

export var sword_duration := .4
export var sword_delay := 1
export var hurt_push := Vector2(-64, 0)
export var direction := 1

func _ready():
	disable_sword()
	scale.x = scale.y * direction
#	$AnimationPlayer.play("Idle")

func _physics_process(_delta):
	pass


func activate_sword():
	$Enemy_Sword.visible = true
	$Enemy_Sword/CollisionShape2D.set_deferred("disabled", false)

	$Enemy_Sword/Timer_Sword.wait_time = sword_duration
	$Enemy_Sword/Timer_Sword.start()

	$Enemy_Sword/Timer_Sword_delay.wait_time = sword_delay
	$Enemy_Sword/Timer_Sword_delay.start()
	can_attack = false
#
func disable_sword():
	$Enemy_Sword.visible = false
	$Enemy_Sword/CollisionShape2D.disabled = true

func _on_Timer_Sword_timeout():
	disable_sword()

func _on_Timer_Sword_delay_timeout():
	can_attack = true

func _on_Area2D_area_entered(area):
	$Timer_Attack_Pattern.start()
	if area.name == "Sword": hurt()
	if can_attack: activate_sword()

func hurt():
	enemy_hp -= 1
	if enemy_hp == 0: die()
#	print(enemy_hp)

func die():
	queue_free()

func _on_Timer_Attack_Pattern_timeout():
	can_attack = true
	activate_sword()
