extends Node2D

class_name Player

func _ready():
	$KinematicBody2D/Hands/AnimationPlayer.play("idle")

var cur_scale = 1
export var can_move: bool = true
export var being_hit: bool = false

export var hp: int = 1

func get_hit():
	being_hit = true

func done_hit():
	being_hit = false

var manshroom: Manshroom = null

func kill_manshroom():
	manshroom.queue_free()
	manshroom = null

func take_hp():
	hp += 1

func lose_hp():
	hp -= 1
	
	if hp <= 0:
		$KinematicBody2D/Hands/AnimationPlayer.play("die")

func restart():
	get_tree().reload_current_scene()

func _process(_delta):
	var cast: RayCast2D = $KinematicBody2D/RayCast2D
	var collider = cast.get_collider()
	var colliding_manshroom = collider != null and collider is Manshroom
	
	var whisperPlayer = $KinematicBody2D/manshroomWhisperPlayer

	if whisperPlayer.playing != colliding_manshroom:
		whisperPlayer.playing = colliding_manshroom

	if not being_hit:
		if Input.is_action_just_pressed("ui_accept"):
			if colliding_manshroom:
				manshroom = collider

				$KinematicBody2D/Hands/AnimationPlayer.play("grab")
	
	var hpBar = $CanvasLayer/HBoxContainer
	
	for i in range(hpBar.get_child_count()):
		hpBar.get_child(i).visible = hp > i

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
