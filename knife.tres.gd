extends Node2D

class_name BlackWeapon

func _ready():
	$AnimationPlayer.play("idle")
	hitting = false


export var hitting: bool = false

var victim: Player = null

func stop_hitting_victim():
	if victim != null:
		victim.done_hit()
		victim.lose_hp()

func _on_Area2D_body_entered(body: CollisionObject2D):
	if body != null and not hitting:
		var owner: Node = body.owner
		if owner is Player:
			$AnimationPlayer.play("hit")
			owner.get_hit()
			victim = owner

