extends Node2D

class_name Player

func _ready():
	$KinematicBody2D/Hands/AnimationPlayer.play("idle")

var cur_scale = 1
export var can_move: bool = true
export var being_hit: bool = false

func get_hit():
	being_hit = true

func done_hit():
	being_hit = false

func _process(_delta):

	if not being_hit:
		if Input.is_action_just_pressed("ui_accept"):
			$KinematicBody2D/Hands/AnimationPlayer.play("grab")
	


func _physics_process(_delta):
	var walking = false

	if can_move and not being_hit:
		var horiz = Input.get_axis("ui_left", "ui_right")

		if (horiz > 0 and cur_scale < 0) or (horiz < 0 and cur_scale > 0):
			$KinematicBody2D.scale.x = -1
			cur_scale = -cur_scale
		$KinematicBody2D.move_and_slide(Vector2(horiz * 100.0, 100))

		if abs(horiz) > 0.001:
			walking = true

	var walkSOund = $KinematicBody2D/walkSound
	if walkSOund.playing != walking:
		walkSOund.playing = walking
