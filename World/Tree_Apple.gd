extends Node2D

export (PackedScene) var apple

func _on_Tree_tree_dead(apple_pos):
	var a = apple.instance()
#	a.position = apple_pos
	$apple_container.add_child(a)
