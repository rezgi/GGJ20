extends RigidBody2D


func _on_apple_area_body_entered(body):
	if body.name == "Player": queue_free()
