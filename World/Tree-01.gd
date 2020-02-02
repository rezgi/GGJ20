extends Area2D

signal tree_dead

func _on_Tree_area_entered(area):
	if area.name == "Sword":
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("tree_dead", $apple_pos.position)
		queue_free()

