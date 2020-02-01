extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("enemy_touched", $"Enemy-01", "func")
