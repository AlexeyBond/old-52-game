extends Node2D

func _ready():
	$KinematicBody2D/Hands/AnimationPlayer.play("idle")

var cur_scale = 1
export var can_move: bool = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$KinematicBody2D/Hands/AnimationPlayer.play("grab")

func _physics_process(_delta):
	if can_move:
		var horiz = Input.get_axis("ui_left", "ui_right")

		if (horiz > 0 and cur_scale < 0) or (horiz < 0 and cur_scale > 0):
			$KinematicBody2D.scale.x = -1
			cur_scale = -cur_scale
		$KinematicBody2D.move_and_slide(Vector2(horiz * 100.0, 100))
