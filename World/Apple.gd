extends RigidBody2D


func _on_apple_area_body_entered(body):
	if body.name == "Player": queue_free()


#@Rezgi I have a susupicion it may be that the object is sleeping. 2 options to fix:
#1. change the settings on your rigidbody so it never sleeps
#or
#2. call apply_impulse(Vector2()) on the apple when you chop it down to wake it up
#apply_impulse with a 0,0 vector will not affect the velocity of the apple but it will stop it from sleeping
