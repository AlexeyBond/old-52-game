extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var cur_scale = 1

func _physics_process(delta):
	var horiz = Input.get_axis("ui_left", "ui_right")
	
	#$RigidBody2D.apply_impulse(Vector2(0, 0), Vector2(horiz, 0) * 10.0)
	if (horiz > 0 and cur_scale < 0) or (horiz < 0 and cur_scale > 0):
		$KinematicBody2D.scale.x = -1
		cur_scale = -cur_scale
	$KinematicBody2D.move_and_slide(Vector2(horiz * 100.0, 100))

